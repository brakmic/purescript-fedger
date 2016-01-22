
// module API.Fedger

var jQuery = $ = require('jquery');

//************************************  COMPANY API **************************/

var getFundingDetails = function(options){
  var api = getApiName(options);
  var opts = convertQueryFor(api, options);
  var json = queryService(opts);
  return json;
};

var getFundingStatus = function(options){
  options = _options4;
  return queryService(options);
};

var getFundings = function(options){
  options = _options4;
  return queryService(options);
};

var getCompanyInsights = function(options){
  options = _options4;
  return queryService(options);
};

var getInvestors = function(options){
  options = _options4;
  return queryService(options);
};

var getLocations = function(options){
  options = _options4;
  return queryService(options);
};

var getLogo = function(options){
  var api = getApiName(options);
  var opts = convertQueryFor(api, options);
  var json = queryService(opts);
  return json;
};

var getPeers = function(options){
  options = _options4;
  return queryService(options);
};

var getPortfolioCompanies = function(options){
  options = _options4;
  return queryService(options);
};

var getCompanySnapshot = function(options){
  var api = getApiName(options);
  var opts = convertQueryFor(api, options);
  var json = queryService(opts);
  return json;
};

var getTeamDetails = function(option){
  options = _options4;
  return queryService(options);
};

/********************* DISCOVER API ***********************************/

var getDiscovery = function(options) {
  options = _options4;
  return queryService(options);
};

var getDiscoveryCompanies = function(options) {
  options = _options4;
  return queryService(options);
};

var getDiscoveryVertices = function(options){
  options = _options4;
  return queryService(options);
};

/********************* GEO API ***************************************/

var getGeoLocatedCompanies = function(options){
  options = _options4;
  return queryService(options);
};

var getGeoLocatedFundings = function(options){
  options = _options4;
  return queryService(options);
};

/********************* NEWS API **************************************/

var getLatestFundings = function (options) {
  options = _options4;
  return queryService(options);
}

/********************* STATS API *************************************/

var getStatsFundings = function(options) {
  options = _options4;
  return queryService(options);
};

/********************** TAGGED API ***********************************/

var getTaggedCompanies = function(options) {
  options = _options4;
  return queryService(options);
};

var getTaggedFundings = function(options){
  options = _options4;
  return queryService(options);
};

/**************** HELPERS ***************************/

var logRaw = function(str) {
  return function () {
    console.log(str);
    return {};
  };
};

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

/****** CONVERTERS **********************************/

var fedgerBaseUri = 'https://api.fedger.io/v1';


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
    'getFundingDetails' : {

                            'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      'giantswarm.io/funding/details?apikey=' +
                                      raw.value0.apikey

                          },
    'getLogo'           : {
                            'url': fedgerBaseUri + '/company/' +
                                                raw.value0.domain +
                                                '/logo?apikey=' +
                                                raw.value0.apikey
                          },
    'getCompanySnapshot' : {
                             'url': fedgerBaseUri + '/company/' +
                                                raw.value0.domain +
                                                '/snapshot?apikey=' +
                                                raw.value0.apikey
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