// changed to js so I could add comments
module.exports = {
  loggedIn: false,
  appUser: 1,
  appOrg: 1,

  // moved permission and other app constants to the bottom level of the structure.
  permission_levels: {
    site_employee: {
      pretty_name: "Site Employee",
      code: 0
    },
    site_manager: {
      pretty_name: "Site Manager",
      code: 1
    },
    org_employee: {
      pretty_name: "Org Employee",
      code: 2
    },
    org_manager: {
      pretty_name: "Org Manager",
      code: 3
    },
    global_admin: {
      pretty_name: "Global Admin",
      code: 4
    },
    global_dataviewer: {
      pretty_name: "Global Dataviewer",
      code: 5
    }
  },

  // Having it as a hash allows us to have a plain english version as well as a "code" version that can align with the enum
  sitePopulations: {
    0: "Men",
    1: "Women",
    2: "Mixed Adult",
    3: "Children",
    4: "Family"
  },

  // We may want to avoid this for mvp
  siteServices: {
    0: "Meals",
    1: "Snacks",
    2: "Showers"
  },

  // having a model on the frontend that mirrors the db structure allows you to reduce the duplication of your data.
  // eg, if site A is updated, you only have to update one reference
  dbData: {
    sites: {
      1: {
        org: 1,
        programName: "The Schoolhouse",
        phone: "416-960-9240",
        address: "349 George St Toronto ON M5A 2N2",
        web: "www.dixonhall.org",
        email: "Harvey.stein@dixonhall.org",
        hours: "Mon-Sun 4 pm-8 am, Sat-Sun 24 hours",
        eligibility: ["men"],
        eligibilityNotes: "",
        services: "",
        latitude: 43.660144,
        longitude: -79.374306,
        fid: "MET1171",
        id: 1,
        capacity: 40,
        // TODO: need to add headcount, room info.
        headcounts: {
          12: {
            recordedBy: 1
          }
        }
      },
      2: {
        org: 1,
        programName: "Heyworth House",
        phone: "416-691-0012",
        address: "2714 Danforth Ave Toronto ON M4C 1L7",
        web: "www.dixonhall.org",
        email: "haydar.shouly@dixonhall.org",
        hours: "Mon-Sun 24 hours",
        eligibility: ["mixed adult"],
        eligibilityNotes: "24+",
        services: "",
        latitude: 43.689116,
        longitude: -79.298255,
        fid: "MET5172",
        id: 2,
        capacity: 83
      }
    },
    orgs: {
      1: {
        name: "Dixon Hall Neighbourhood Services",
        id: 1,
        orgUsers: [
          {
            first_name: "Andrew",
            last_name: "Carreiro",
            email: "andrewcarreiro@gmail.com",
            userPermissions: [
              {
                siteId: "",
                permissionLevel: ""
              }
            ]
          }
        ]
      }
    },
    users: {
      1: {
        permissions: [
          // site employee at site ID 1
          {
            scope: 0,
            site: 1,
            org: null
          }
        ],
        id: 1,
        firstName: "Jackie",
        lastName: "Lealess",
        email: "jackie@internet.com",
        role: "Organization Manager"
      },
      2: {
        permissions: [
          // global manager
          {
            scope: 4,
            site: null,
            org: null
          }
        ],
        id: 2,
        firstName: "Andrew",
        lastName: "Carreiro",
        email: "andrewcarreiro@gmail.com",
        role: "Site Manager"
      },
      3: {
        permissions: [
          // Site Employee
          {
            scope: 0,
            site: null,
            org: null
          }
        ],
        id: 3,
        firstName: "Scott",
        lastName: "Agirs",
        email: "scott.agirs@gmail.com",
        role: "Site Employee"
      },
      4: {
        permissions: [
          // Site Employee
          {
            scope: 0,
            site: null,
            org: null
          }
        ],
        id: 4,
        firstName: "Jane",
        lastName: "Ohio",
        email: "jane.ohio222222@gmail.com",
        role: "Site Employee"
      }
    }
    // TODO: need to add schedule, possibly.
  }
};
