module API.Fedger where

import Prelude
import Control.Bind
import Control.Monad.Eff
import Control.Monad.Eff.Console (CONSOLE(), log, print)

-- | Fedger Effects & Types
foreign import data FedgerM     :: !
foreign import data Fedger      :: *
foreign import data CompanyLogo :: *

type FedgerEff a = forall e. Eff (fedgerM :: FedgerM | e) a

-- | Logging helper
foreign import logRaw :: forall a e. a -> Eff (console :: CONSOLE | e) Unit

-- | Queries

data FundingDetailsQuery = FundingDetailsQuery {
  domain :: String,
  apikey :: String
}

data LogoQuery = LogoQuery {
  domain :: String,
  apikey :: String
}

data CompanySnapshotQuery = CompanySnapshotQuery {
  domain :: String,
  apikey :: String
}

-- | Responses

data FundingDetailsResponse = FundingDetailsResponse {
  domain         :: String,
  "amount_total" :: Number,
  currency       :: String,
  rounds         :: Array String
}

data LogoResponse = LogoResponse {
  binary :: String
}

data CompanySnapshotResponse = CompanySnapshotResponse {
  "domain"        :: String,
  "name"          :: String,
  "slug"          :: String,
  "phone"         :: String,
  "dateFounded"   :: String,
  "fundingLevel"  :: String,
  "urlTwitter"    :: String,
  "urlLinkedIn"   :: String,
  "urlAngellist"  :: String,
  "urlCrunchbase" :: String
}

-- | Company API
foreign import getFundingDetails      :: forall e. FundingDetailsQuery -> (FundingDetailsResponse -> Eff e Unit) -> FedgerEff Unit
foreign import getFundingStatus       :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getFundings            :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getCompanyInsight      :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getInvestors           :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getLocations           :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getLogo                :: forall e. LogoQuery -> (LogoResponse -> Eff e Unit) -> FedgerEff Unit
foreign import getPeers               :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getPortfolioCompanies  :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getCompanySnapshot     :: forall e. CompanySnapshotQuery -> (CompanySnapshotResponse -> Eff e Unit) -> FedgerEff Unit
foreign import getTeamDetails         :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit

-- | Discover API
foreign import getDiscovery           :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getDiscoveryCompanies  :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getDiscoveryVertices   :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit

-- | Geo API
foreign import getGeoLocatedCompanies :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getGeoLocatedFundings  :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit

-- | News API
foreign import getLatestFundings      :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit

-- | Stats API
foreign import getStatsFundings       :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit

-- | Tagged API
foreign import getTaggedCompanies     :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit
foreign import getTaggedFundings      :: forall a e. a -> (String -> Eff e Unit) -> FedgerEff Unit