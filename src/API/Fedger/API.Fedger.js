
// module API.Fedger

var jQuery = $ = require('jquery');

//placeholder for currently not implemented APIs
_options4 = {
              'domain': '',
              'apikey': ''
            };

//************************************  COMPANY API **************************/

var getFundingDetails = function(options){
  /*var api = getApiName(options);
  var opts = convertQueryFor(api, options);
  var json = queryService(opts);
  return json;*/
  return callApi(options);
};

var getFundingStatus = function(options){
  return callApi(options);
};

var getFundings = function(options){
  return callApi(options);
};

var getCompanyInsights = function(options){
  return callApi(options);
};

var getInvestors = function(options){
  return callApi(options);
};

var getLocations = function(options){
  return callApi(options);
};

var getLogo = function(options){
  return callApi(options);
};

var getPeers = function(options){
  return callApi(options);
};

var getPortfolioCompanies = function(options){
  return callApi(options);
};

var getCompanySnapshot = function(options){
  return callApi(options);
};

var getTeamDetails = function(option){
  return callApi(options);
};

/********************* DISCOVER API ***********************************/

var getDiscovery = function(options) {
  return callApi(options);
};

var getDiscoveryCompanies = function(options) {
  return callApi(options);
};

var getDiscoveryVertices = function(options){
  return callApi(options);
};

/********************* GEO API ***************************************/

var getGeoLocatedCompanies = function(options){
  return callApi(options);
};

var getGeoLocatedFundings = function(options){
  return callApi(options);
};

/********************* NEWS API **************************************/

var getLatestFundings = function (options) {
  return callApi(options);
}

/********************* STATS API *************************************/

var getStatsFundings = function(options) {
  return callApi(options);
};

/********************** TAGGED API ***********************************/

var getTaggedCompanies = function(options) {
  return callApi(options);
};

var getTaggedFundings = function(options){
  return callApi(options);
};

/**************** HELPERS ***************************/

var logRaw = function(str) {
  return function () {
    console.log(str);
    return {};
  };
};

//This is a helper for creating internal callbacks to process responses.
var createCallback = function(api, callback){
  var cb = null;
  if(callback &&
       callback.constructor &&
       callback.constructor.name == 'Nothing'){
        cb = function(ignore){
          var ignr = ignore.then(function(){
            return {};
          }).catch(function(error){
            console.log(api + ' failed, error: ' + error);
          });
          var ret = function(){
            return ignr;
          };
          return ret;
      };
    } else {
      cb = function(val){
        return function(){
          val.then(function(v){
            //convert JS-response into PS-response
            var result = convertResponseFor(api, v);
            callback(result)();
          }).catch(function(err){
            console.error(err);
          });
          return {};
        }
      };
    }
    return cb;
};

//All API-calls go through this function
var callApi = function(options){
  var api = getApiName(options);
  var opts = convertQueryFor(api, options);
  var json = queryService(opts);
  return json;
}

//All Service-Queries go through this function.
var queryService = function(options){
  return function(callback){
    var cb = createCallback(options.api, callback);
    return function(){
       var jq = Promise.resolve($.ajax({
                    method: options.method,
                    url: options.url,
                    async: options.async,
                    dataType: options.dataType,
                    crossDomain: true,
                    })
                    .done(function( msg ) {
                      return msg;
                    }));

      cb(jq)();
      return {};
    };
  };
}
//Helper to construct the proper name of currently used API-call
var getApiName = function(options){
  var apiName = null;
  if(options){
    if(options.constructor &&
      options.constructor.name){
      apiName = 'get' + options.constructor.name.replace('Query','');
    }
  }
  return apiName;
};

/*********************** CONVERTERS **********************************/

var fedgerBaseUri = 'https://api.fedger.io/v1';

//Below are tables defined which help to select correct data structures
//for further processing on the PureScript side.

var convertResponseFor = function(api, raw){
  var mapResponses = {
      'getFundingDetails' : {
                              'domain'       : raw.domain,
                              'amount_total' : raw.amount_total,
                              'currency'     : raw.currency,
                              'rounds'       : raw.rounds
                            },
      'getLogo'           : {
                              'data' : raw
                            },
      'getCompanySnapshot' : {
                                'dateFounded'   : raw.dateFounded,
                                'fundingLevel'  : raw.fundingLevel,
                                'urlAngellist'  : raw.urlAngellist,
                                'urlTwitter'    : raw.urlTwitter,
                                'urlCrunchbase' : raw.urlCrunchbase,
                                'urlLinkedIn'   : raw.urlLinkedIn,
                                'slug'          : raw.slug,
                                'name'          : raw.name,
                                'domain'        : raw.domain,
                                'phone'         : raw.phone
                             }
  },
  result = { 'value0': mapResponses[api] };

  return result;
};

var convertQueryFor = function(api, raw){
  //every query contains these arguments
  var defaults = {
    'domain' : raw.value0.domain,
    'apikey' : raw.value0.apikey,
    'method' : 'GET',
    'api' : api
  }, q, query

  mapQueries = {
    'getFundingDetails'     : {

                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'funding/details?apikey=' + raw.value0.apikey

                              },
    'getFundingStatus'      : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'funding/status?apikey=' + raw.value0.apikey
                              },
    'getFundings'           : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'fundings?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getCompanyInsights'    : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'insights/?apikey=' + raw.value0.apikey,
                                'classes' : raw.value0.classes,
                                'cursor'  : raw.value0.cursor
                              },
    'getInvestors'          : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'investors?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getLocations'          : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'locations/details?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getLogo'               : {
                                'url': fedgerBaseUri + '/company/' +
                                                raw.value0.domain +
                                                '/logo?apikey=' +
                                                raw.value0.apikey
                              },
    'getPeers'              : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'peers?apikey=' + raw.value0.apikey,
                              },
    'getPortfolioCompanies' : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'portfolio?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getCompanySnapshot'    : {
                                'url': fedgerBaseUri + '/company/' +
                                                raw.value0.domain +
                                                '/snapshot?apikey=' +
                                                raw.value0.apikey
                              },
    'getTeamDetails'        : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'team/details?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              }
  };

  q = mapQueries[api];
  query = Object.assign({}, q, defaults);
  return query;
};

/****************************************************/

module.exports = {
  //HELPERS
  logRaw                 : logRaw,
  //COMPANY API
  getFundingDetails      : getFundingDetails,
  getFundingStatus       : getFundingStatus,
  getFundings            : getFundings,
  getCompanyInsights     : getCompanyInsights,
  getInvestors           : getInvestors,
  getLocations           : getLocations,
  getLogo                : getLogo,
  getPeers               : getPeers,
  getPortfolioCompanies  : getPortfolioCompanies,
  getCompanySnapshot     : getCompanySnapshot,
  getTeamDetails         : getTeamDetails,
  //DISCOVER API
  getDiscovery           : getDiscovery,
  getDiscoveryCompanies  : getDiscoveryCompanies,
  getDiscoveryVertices   : getDiscoveryVertices,
  //GEO API
  getGeoLocatedCompanies : getGeoLocatedCompanies,
  getGeoLocatedFundings  : getGeoLocatedFundings,
  //NEWS API
  getLatestFundings      : getLatestFundings,
  //STATS API
  getStatsFundings       : getStatsFundings,
  //TAGGED API
  getTaggedCompanies     : getTaggedCompanies,
  getTaggedFundings      : getTaggedFundings
};