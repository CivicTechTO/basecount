
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
  if(dataToSend){
    fetchParams.body = JSON.stringify(dataToSend);
  }

  // TODO: need standardized errors around logged in / logged out issues

  return fetch(
      url,
      fetchParams
    )
    .then( response => response.json())
}

// ---------------------
// Backend access methods
// ---------------------

/** gets the base state for the application */
export const getState = () => backendRequest("/api/base_state", "get");

// TODO: add methods for all backend requests