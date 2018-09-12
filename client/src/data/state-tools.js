// Gets the current application org or null
export const getAppOrg = ( state ) => {
  return state.dbData &&
        state.dbData.orgs &&
        state.appOrg &&
        state.dbData.orgs[state.appOrg] ?
        state.dbData.orgs[state.appOrg] : null
};
