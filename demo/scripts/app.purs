module DemoApp.Fedger where

import Prelude (Unit, bind, (++), unit, pure)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE(), log)
import API.Fedger   (FedgerM,
                    CompanySnapshotQuery(CompanySnapshotQuery),
                    CompanySnapshotResponse(CompanySnapshotResponse),
                    FundingDetailsResponse(FundingDetailsResponse),
                    LogoResponse(LogoResponse),
                    getCompanySnapshot)


companySnapshotCB :: forall e. CompanySnapshotResponse -> Eff (console :: CONSOLE | e) Unit
companySnapshotCB = \(CompanySnapshotResponse r) -> do
                                                    log ("Company: "       ++ r.name          ++ "\r\n" ++
                                                         "Funding Level: " ++ r.fundingLevel  ++ "\r\n" ++
                                                         "Slug: "          ++ r.slug          ++ "\r\n" ++
                                                         "Twitter: "       ++ r.urlTwitter    ++ "\r\n" ++
                                                         "Crunchbase: "    ++ r.urlCrunchbase ++ "\r\n")



fundingDetailsCB :: forall e. FundingDetailsResponse -> Eff (console :: CONSOLE | e) Unit
fundingDetailsCB = \(FundingDetailsResponse r) -> do
                                                  log ("DOMAIN: " ++ r.domain ++ "")
                                                  pure unit

logoCB :: forall e. LogoResponse -> Eff(console :: CONSOLE | e) Unit
logoCB = \(LogoResponse r) -> do
                              log ("logo: " ++ r.binary)


main ::  forall e. Eff (console :: CONSOLE, fedgerM :: FedgerM | e) Unit
main = do
      --let fundingDetailsQuery = FundingDetailsQuery { domain : "giantswarm.io", apikey : "YOUR_API_KEY_HERE" }
      --let logoQuery = LogoQuery { domain : "giantswarm.io", apikey : "YOUR_API_KEY_HERE" }
      let snapshotQuery = CompanySnapshotQuery { domain : "giantswarm.io", apikey : "1289ec547f52487dc88cf967ba0eba42" }
      getCompanySnapshot snapshotQuery companySnapshotCB
      --getFundingDetails fundingDetailsQuery fundingDetailsCB
      --getLogo logoQuery logoCB