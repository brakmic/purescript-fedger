module DemoApp.Fedger where

import Prelude                       (Unit, bind, (++), unit, return)
import Control.Monad.Eff             (Eff)
import Data.List                     (List(Nil, Cons))
import Data.Maybe                    (Maybe(Just, Nothing))
import Control.Monad.Eff.Console     (CONSOLE(), log)
import API.Fedger
import API.Fedger.Messages.Queries
import API.Fedger.Messages.Responses
import API.Fedger.Messages.Partials
import Optic.Lens.Simple             (Lens, (^.), lens)

-- | -----------------------  Lenses ----------------------------------

vertices_ :: Lens DiscoveryData (List Vertice)
vertices_ = lens _.vertices (_ { vertices = _ })

edges_ :: Lens DiscoveryData (List Edge)
edges_ = lens _.edges (_ { edges = _ })

-- | -----------------------   Callbacks ------------------------------
companySnapshotCB :: forall e. CompanySnapshotResponse -> Eff (console :: CONSOLE | e) Unit
companySnapshotCB = \(CompanySnapshotResponse r) -> do
                                                    log ("Company: "       ++ r.name          ++ "\r\n" ++
                                                         "Funding Level: " ++ r.fundingLevel  ++ "\r\n" ++
                                                         "Slug: "          ++ r.slug          ++ "\r\n" ++
                                                         "Twitter: "       ++ r.urlTwitter    ++ "\r\n" ++
                                                         "Crunchbase: "    ++ r.urlCrunchbase ++ "\r\n")



fundingDetailsCB :: forall e. FundingDetailsResponse -> Eff (console :: CONSOLE | e) Unit
fundingDetailsCB = \(FundingDetailsResponse r) -> do
                                                  let inv = Investor {
                                                                      "type" : "1",
                                                                      "name" : "2",
                                                                      "slug" : "3",
                                                                      "domain" : "4"
                                                                    }
                                                  let _round = Round {
                                                                        "date"  : 1,
                                                                        "amount"  : 2,
                                                                        "currency" : "EUR",
                                                                        "round" : "Seed",
                                                                        "investors" : Cons inv Nil
                                                                      }
                                                  let test = FundingDetailsResponse { "name" : "1",
                                                                                      "domain" : "2" ,
                                                                                      "amount_total" : 3,
                                                                                      "currency" : "4",
                                                                                      "rounds"  : Cons _round Nil
                                                                                    }
                                                  -- logRaw r.rounds
                                                  logRaw test

logoCB :: forall e. LogoResponse -> Eff(console :: CONSOLE | e) Unit
logoCB = \(LogoResponse r) -> do
                              log ("logo: " ++ r.binary)


logAnyResponse :: forall a e. a -> Eff (console :: CONSOLE | e) Unit
logAnyResponse = \anyResponse -> do
                                 logRaw anyResponse

logDiscovery :: forall e. DiscoveryResponse -> Eff (console :: CONSOLE | e) Unit
logDiscovery = \(DiscoveryResponse r) -> do
                                        let vs = (r.data ^. vertices_)
                                        let es = (r.data ^. edges_)
                                        log "VERTICES"
                                        logRaw vs -- show vertices
                                        log "EDGES"
                                        logRaw es -- show edges
                                        return unit

logDiscoveryCompanies :: forall e. DiscoveryCompaniesResponse -> Eff (console :: CONSOLE | e) Unit
logDiscoveryCompanies = \(DiscoveryCompaniesResponse r) -> do
                                                          logRaw r.data
                                                          return unit

logDiscoveryVertices :: forall e. DiscoveryVerticesResponse -> Eff (console :: CONSOLE | e) Unit
logDiscoveryVertices = \(DiscoveryVerticesResponse r) -> do
                                                        logRaw r.data -- show vertices
                                                        return unit

logInvestors :: forall e. InvestorsResponse -> Eff (console :: CONSOLE | e) Unit
logInvestors = \(InvestorsResponse r) -> do
                                        --let inv = Just (Investor { "type" : "1", "name" : "2", "slug" : "3", "domain" : "4" })
                                        --logRaw inv
                                        --logRaw $ (head r.investors) :: (Maybe Investor)
                                        logRaw r
                                        return unit


-- | ------------------------ End of Callbacks -----------------------


main ::  forall e. Eff (console :: CONSOLE, fedgerM :: FedgerM | e) Unit
main = do
      let myApiKey = "YOUR_API_KEY_HERE"
      -- | ********************************** QUERY CONFIGS ***********************************************
      -- let discoveryQuery = DiscoveryQuery { s : "oracle", crossDomain : true, apikey : myApiKey }
      -- let discoveryCompaniesQuery = DiscoveryCompaniesQuery { s : "oracle", crossDomain : true, apikey : myApiKey, cursor : 0 }
      -- let discoveryVerticesQuery = DiscoveryVerticesQuery { s : "oracle", crossDomain : true, apikey : myApiKey, cursor : 0 }
      -- let investorsQuery = InvestorsQuery { domain : "arangodb.com", crossDomain : true, apikey : myApiKey, cursor : 0 }
      let fundingDetailsQuery = FundingDetailsQuery { domain : "giantswarm", crossDomain : true, apikey : myApiKey }
      -- let logoQuery = LogoQuery { domain : "giantswarm.io", crossDomain : true, apikey : myApiKey }
      -- let snapshotQuery = CompanySnapshotQuery { domain : "giantswarm.io", crossDomain : true, apikey : myApiKey }
      -- let geoLocatedCompaniesQuery = GeoLocatedCompaniesQuery { country_code : "DE", cities : (Cons "Berlin" Nil),
      --                                                           cursor : 0, apikey: myApiKey, crossDomain : true }
      -- let geoLocatedFundingsQuery = GeoLocatedFundingsQuery { country_code : "DE", cities : (Cons "Berlin" Nil),
      --                                                         range_from : 0, range_to : 0, --<<<--- unused!
      --                                                         cursor : 0, apikey: myApiKey, crossDomain : true }
      -- let latestFundingsQuery = LatestFundingsQuery { apikey: myApiKey, crossDomain : true }
      -- let statsFundingsQuery = StatsFundingsQuery { year : 2015, month : Nothing, country : Nothing,
      --                                               tag : Nothing, apikey: myApiKey, crossDomain : true }
      {-let taggedCompaniesQuery = TaggedCompaniesQuery { tags : "oracle, microsoft", isJoin : Just true, cursor : Just 0,
                                                         apikey: myApiKey, crossDomain : true }-}
      let taggedFundingsQuery = TaggedFundingsQuery { tags : "oracle, microsoft", range_from : Nothing, range_to : Nothing,
                                                         isJoin : Just true, cursor : Just 0,
                                                         apikey: myApiKey, crossDomain : true }

      -- | ********************************* QUERY COMMANDS ***********************************************
      -- getCompanySnapshot snapshotQuery companySnapshotCB
      getFundingDetails fundingDetailsQuery fundingDetailsCB
      -- getLogo logoQuery logoCB
      -- getInvestors investorsQuery logInvestors
      -- getDiscovery discoveryQuery logDiscovery
      -- getDiscoveryCompanies discoveryCompaniesQuery logDiscoveryCompanies
      -- getDiscoveryVertices discoveryVerticesQuery logDiscoveryVertices
      -- getGeoLocatedCompanies geoLocatedCompaniesQuery logAnyResponse
      -- getGeoLocatedFundings geoLocatedFundingsQuery logAnyResponse
      -- getLatestFundings latestFundingsQuery logAnyResponse
      -- getStatsFundings statsFundingsQuery logAnyResponse
      -- getTaggedCompanies taggedCompaniesQuery logAnyResponse
      getTaggedFundings taggedFundingsQuery logAnyResponse
