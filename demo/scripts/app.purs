module DemoApp.Fedger where

import Prelude                       (Unit, bind, (++))
import Control.Monad.Eff             (Eff)
import Control.Monad.Eff.Console     (CONSOLE(), log)
import API.Fedger                    (..)
import API.Fedger.Messages.Queries   (..)
import API.Fedger.Messages.Responses (..)

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
                                                  logRaw r

logoCB :: forall e. LogoResponse -> Eff(console :: CONSOLE | e) Unit
logoCB = \(LogoResponse r) -> do
                              log ("logo: " ++ r.binary)


logAnyResponse :: forall a e. a -> Eff (console :: CONSOLE | e) Unit
logAnyResponse = \anyResponse -> do
                                 logRaw anyResponse

-- | ------------------------ End of Callbacks -----------------------


main ::  forall e. Eff (console :: CONSOLE, fedgerM :: FedgerM | e) Unit
main = do
      let myApiKey = "1289ec547f52487dc88cf967ba0eba42"
      let investorsQuery = InvestorsQuery { domain : "arangodb.com", crossDomain : true, apikey : myApiKey, cursor: 0 }
      --let fundingDetailsQuery = FundingDetailsQuery { domain : "arangodb.com", crossDomain : true, apikey : myApiKey }
      --let logoQuery = LogoQuery { domain : "giantswarm.io", crossDomain : true, apikey : myApiKey }
      --let snapshotQuery = CompanySnapshotQuery { domain : "giantswarm.io", crossDomain : true, apikey : myApiKey }
      --getCompanySnapshot snapshotQuery companySnapshotCB
      --getFundingDetails fundingDetailsQuery fundingDetailsCB
      --getLogo logoQuery logoCB
      getInvestors investorsQuery logAnyResponse