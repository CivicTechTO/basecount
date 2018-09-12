let CSRF_TOKEN = null;

const backendRequest = ( url, verb, dataToSend = null ) => {
  const accepted_verbs = ['get', 'post', 'delete', 'put'];
  if( ! accepted_verbs.includes(verb.toLowerCase()) ){
    throw new Error(`${verb} is an invalid HTTP verb.`);
  }

  const fetchParams = {
    method: verb.toUpperCase(),
    mode: "cors", // no-cors, cors, *same-origin
    cache: "no-cache", // *default, no-cache, reload, force-cache, only-if-cached
    credentials: "include", // "same-origin", // include, same-origin, *omit
    headers: {
        "Content-Type": "application/json; charset=utf-8",
        // "Content-Type": "application/x-www-form-urlencoded",
    },
    redirect: "follow", // manual, *follow, error
    referrer: "no-referrer", // no-referrer, *client
  }

  // if(CSRF_TOKEN) {
  //   fetchParams.headers['X-CSRF-Token'] = CSRF_TOKEN;
  // }

  if(dataToSend){
    const tokenObject = {};
    if(CSRF_TOKEN) {
      tokenObject['authenticity_token'] = CSRF_TOKEN;
    }
    fetchParams.body = JSON.stringify(Object.assign({},tokenObject,dataToSend));
  }

  // TODO: need standardized errors around logged in / logged out issues

  let isResponseOk = null;

  return fetch(
      url,
      fetchParams
    )
    .then( response => {
      // at this point, the csrf token could be set in a cookie. We should save it now.
      const cookies = getCookieHash();
      CSRF_TOKEN = cookies['XSRF-TOKEN'] ? cookies['XSRF-TOKEN'] : CSRF_TOKEN;

      isResponseOk = response.ok;

      //jsonify it
      return response.json();
    })
    // if the http code is bad, allow downstream code to be responsible for catching
    .then( responseJSON => {
      if(isResponseOk){
        return responseJSON;
      }

      throw responseJSON;
    })
}

// converts document.cookie into a usable object
const getCookieHash = () => {
  const cookieHash = {};

  document.cookie
    .split("&")
    .map( c => c.split("=") )
    .forEach( c => {
      cookieHash[c[0]] = c[1];
    });
  
  return cookieHash;
};

// ---------------------
// Backend access methods
// ---------------------

/** gets the base state for the application */
export const getState = () => backendRequest("/api/base_state", "get");
export const postLogin = ({username,password,remember_me}) => backendRequest("/users/sign_in", "post", {
  "user": {
    "email": username,
    "password": password,
  }
  // "user[remember_me]": remember_me ? 1 : 0,
  // "commit": "Log in"
});

// TODO: add methods for all backend requests