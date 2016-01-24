
// module API.Fedger

var jQuery     = $ = require('jquery');

//we need these imports to map weakly-typed JSONs into PureScript-Objects
var Data_List  = require("Data.List");
var _Queries   = require("API.Fedger.Messages.Queries");
var _Responses = require("API.Fedger.Messages.Responses");
var _Partials  = require("API.Fedger.Messages.Partials");

var fedgerBaseUri = 'https://api.fedger.io/v1';

//************************************  COMPANY API **************************/

var getFundingDetails = function(options){
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
};

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
};

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
                    crossDomain: options.crossDomain,
                    })
                    .done(function( msg ) {
                      return msg;
                    }));

      cb(jq)();
      return {};
    };
  };
};
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

/*********************** CONVERTERS + BOILERPLATE***************************/

var toPSList = function(jsList){
  var list = [];
  if(jsList){
    if(jsList[0] && jsList[1]){
      list = Data_List.Cons.create(jsList[0])(jsList.splice(1));
    }else{
      list = Data_List.Cons.create(jsList[0])(Data_List.Nil.value);
    }
  }else{
    list = Data_List.Cons.create(Data_List.Nil.value)(Data_List.Nil.value);
  }
  return list;
};

var createRound = function(rnd){
  rnd.investors = createInvestors(rnd.investors);
  var round = _Partials.Round.create(rnd);
  return round;
};

var createRounds = function(rnds){
  if(!rnds)return;
  var rounds = [];
  for (var i = rnds.length - 1; i >= 0; i--) {
    rounds.push(createRound(rnds[i]));
  }
  return rounds;
};

var createInvestor = function(inv){
  var investr = _Partials.Investor.create(inv);
  return investr;
};

var createInvestors = function(invs){
  if(!invs)return;
  var invstrss = [];
  for (var i = invs.length - 1; i >= 0; i--) {
    invstrss.push(createInvestor(invs[i]));
  }
  return invstrss;
};

var createFundings = function(funds){
  if(!funds)return;
  var fndss = [];
  for (var i = funds.length - 1; i >= 0; i--) {
    fndss.push(funds[i]);
  }
  return fndss;
};

var createLocation = function(loc){
  var loc_ = _Partials.Location.create(loc);
  return loc_;
};

var createLocations = function(locs){
  if(!locs)return;
  var locss = [];
  for (var i = locs.length - 1; i >= 0; i--) {
    locss.push(createLocation(locs[i]));
  }
  return locss;
};

var createPeer = function(per){
  var peer = _Partials.Peer.create(per);
  return peer;
};

var createPeers = function(pers){
  if(!pers)return;
  var perss = [];
  for (var i = pers.length - 1; i >= 0; i--) {
    perss.push(createPeer(pers[i]));
  }
  return perss;
};

var createPortfolioEntry = function(por){
  var port = _Partials.Portfolio.create(por);
  return port;
};


var createPortfolio = function(pors){
  if(!pors)return;
  var porss = [];
  for (var i = pors.length - 1; i >= 0; i--) {
    porss.push(createPortfolioEntry(pors[i]));
  }
  return porss;
};

var createVertice = function(ver){
  var vert = _Partials.Vertice.create(ver);
  return vert;
};

var createVertices = function(vers){
  if(!vers)return;
  var verss = [];
  for (var i = vers.length - 1; i >= 0; i--) {
    verss.push(createVertice(vers[i]));
  }
  return verss;
};

var createEdge = function(edg){
  var edge = _Partials.Edge.create(edg);
  return edge;
};

var createEdges = function(edgs){
  if(!edgs)return;
  var edgss = [];
  for (var i = edgs.length - 1; i >= 0; i--) {
    edgss.push(createEdge(edgs[i]));
  }
  return edgss;
};

var createDiscoveryCompaniesEntry = function(dis){
  var disce = _Partials.DiscoveryCompaniesEntry.create(dis);
  return disce;
};

var createDiscoveryCompanies = function(discs){
  if(!discs)return;
  var discss = [];
  for (var i = discs.length - 1; i >= 0; i--) {
    discss.push(createDiscoveryCompaniesEntry(discs[i]));
  }
  return discss;
};

//Below are tables defined which help to select correct data structures
//for further processing on the PureScript side.

var convertResponseFor = function(api, raw){
  var mapResponses = {
      //************** COMPANY API ************************
      'getFundingDetails'      : {
                                   'domain'       : raw.domain,
                                   'amount_total' : raw.amount_total,
                                   'currency'     : raw.currency,
                                   'rounds'       : toPSList(createRounds(raw.rounds))
                                 },
      'getLogo'                : {
                                   'data' : raw
                                 },
      'getFundingStatus'       : {
                                   "domain"       : raw.domain,
                                   "fundingTotal" : raw.amount_total,
                                   "currency"     : raw.currency,
                                   "status"       : raw.status
                                 },
      'getFundings'            : {
                                   'domain'     : raw.domain,
                                   'total_fund' : raw.total_fund,
                                   'currency'   : raw.currency,
                                   'cursor'     : raw.cursor,
                                   'fundings'   : toPSList(raw.fundings) //this list isn't based on Fundings-Type,
                                                                        //it's just a list of strings
                                 },
      'getCompanyInsights'     : {
                                   'cursor' : raw.cursor,
                                   'nodes'  : toPSList(raw.nodes) //just a string list
                                 },
      'getInvestors'           : {
                                   'domain'    : raw.domain,
                                   'cursor'    : raw.cursor,
                                   'investors' : toPSList(createInvestors(raw.investors))
                                 },
      'getLocations'           : {
                                   'domain'    : raw.domain,
                                   'cursor'    : raw.cursor,
                                   'locations' : toPSList(createLocations(raw.locations))
                                 },
      'getPeers'               : {
                                   'domain' : raw.domain,
                                   'peers'  : toPSList(createPeers(raw.peers))
                                },
      'getPortfolioCompanies' : {
                                  'domain'    : raw.domain,
                                  'cursor'    : raw.cursor,
                                  'portfolio' : toPSList(createPortfolio(raw.portfolio))
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
                             },
      'getTeamDetails'      : {
                                 'domain'        : raw.domain,
                                 'name'          : raw.name,
                                 'slug'          : raw.slug,
                                 'phone'         : raw.phone,
                                 'dateFounded'   : raw.dateFounded,
                                 'fundingLevel'  : raw.fundingLevel,
                                 'urlTwitter'    : raw.urlTwitter,
                                 'urlLinkedIn'   : raw.urlLinkedIn,
                                 'urlAngellist'  : raw.Angellist,
                                 'urlCrunchbase' : raw.urlCrunchbase
                              },
      //******************** DISCOVER API ***********************
      'getDiscovery'        : {
                                'data' : raw.data ?
                                {
                                  'vertices' : raw.data.vertices ? toPSList(createVertices(raw.data.vertices)) : toPSList([]),
                                  'edges'    : raw.data.edges    ? toPSList(createEdges(raw.data.edges)) : toPSList([])

                                } //if NULL construct an empty structure
                                : { 'vertices' : toPSList([]), edges : toPSList([]) }
                              },
      'getDiscoveryCompanies' : {
                                  "cursor"      : raw.cursor,
                                  "total_count" : raw.total_count,
                                  "data"        : raw.data ? toPSList(createDiscoveryCompanies(raw.data))
                                   //if NULL construct an empty array
                                  : toPSList([])
                                },
      'getDiscoveryVertices'  : {
                                  "cursor"      : raw.cursor,
                                  "total_count" : raw.total_count,
                                  "data"        : raw.data ? toPSList(createVertices(raw.data))
                                  //if NULL constructr an empty array
                                  : toPSList([])
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
    'api' : api,
    'crossDomain': raw.value0.crossDomain ? raw.value0.crossDomain : true
  }, q, query

  mapQueries = {
    //*************************** COMPANY API *******************************
    'getFundingDetails'     : {

                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/funding/details?apikey=' + raw.value0.apikey

                              },
    'getFundingStatus'      : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/funding/status?apikey=' + raw.value0.apikey
                              },
    'getFundings'           : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/fundings?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getCompanyInsights'    : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/insights/?apikey=' + raw.value0.apikey,
                                'classes' : raw.value0.classes,
                                'cursor'  : raw.value0.cursor
                              },
    'getInvestors'          : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/investors?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getLocations'          : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/locations/details?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getLogo'               : {
                                'url': fedgerBaseUri + '/company/' +
                                                raw.value0.domain +
                                                '/logo?apikey=' +    raw.value0.apikey
                              },
    'getPeers'              : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/peers?apikey=' + raw.value0.apikey,
                              },
    'getPortfolioCompanies' : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/portfolio?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    'getCompanySnapshot'    : {
                                'url': fedgerBaseUri + '/company/' +
                                                raw.value0.domain +
                                                '/snapshot?apikey=' + raw.value0.apikey
                              },
    'getTeamDetails'        : {
                                'url': fedgerBaseUri + '/company/' +
                                                 raw.value0.domain +
                                      '/team/details?apikey=' + raw.value0.apikey,
                                'cursor' : raw.value0.cursor
                              },
    //************************* DISCOVER API ****************************
    'getDiscovery'          : {
                                'url': fedgerBaseUri + '/discover?s=' + raw.value0.s +
                                      '&apikey=' + raw.value0.apikey,
                              },
    'getDiscoveryCompanies' : {
                                'url': fedgerBaseUri + '/discover/companies?s=' + raw.value0.s +
                                      '&apikey=' + raw.value0.apikey,
                              },
    'getDiscoveryVertices'  : {
                                'url': fedgerBaseUri + '/discover/vertices?s=' + raw.value0.s +
                                      '&apikey=' + raw.value0.apikey,
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