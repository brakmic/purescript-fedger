module API.Fedger where

import Prelude                       (Unit, bind)
import Control.Monad.Eff             (Eff)
import Control.Monad.Eff.Console     (CONSOLE())
import API.Fedger.Messages.Queries   (..)
import API.Fedger.Messages.Responses (..)

-- | Fedger Effects & Types
foreign import data FedgerM     :: !
foreign import data Fedger      :: *
foreign import data CompanyLogo :: *

type FedgerEff a = forall e. Eff (fedgerM :: FedgerM | e) a

-- | Logging helper
foreign import logRaw :: forall a e. a -> Eff (console :: CONSOLE | e) Unit


-- | Company API
foreign import getFundingDetails      :: forall e. FundingDetailsQuery     -> (FundingDetailsResponse     -> Eff e Unit) -> FedgerEff Unit
foreign import getFundingStatus       :: forall e. FundingStatusQuery      -> (FundingStatusResponse      -> Eff e Unit) -> FedgerEff Unit
foreign import getFundings            :: forall e. FundingsQuery           -> (FundingsResponse           -> Eff e Unit) -> FedgerEff Unit
foreign import getCompanyInsight      :: forall e. CompanyInsightsQuery    -> (CompanyInsightsResponse    -> Eff e Unit) -> FedgerEff Unit
foreign import getInvestors           :: forall e. InvestorsQuery          -> (InvestorsResponse          -> Eff e Unit) -> FedgerEff Unit
foreign import getLocations           :: forall e. LocationsQuery          -> (LocationsResponse          -> Eff e Unit) -> FedgerEff Unit
foreign import getLogo                :: forall e. LogoQuery               -> (LogoResponse               -> Eff e Unit) -> FedgerEff Unit
foreign import getPeers               :: forall e. PeersQuery              -> (PeersResponse              -> Eff e Unit) -> FedgerEff Unit
foreign import getPortfolioCompanies  :: forall e. PortfolioCompaniesQuery -> (PortfolioCompaniesResponse -> Eff e Unit) -> FedgerEff Unit
foreign import getCompanySnapshot     :: forall e. CompanySnapshotQuery    -> (CompanySnapshotResponse    -> Eff e Unit) -> FedgerEff Unit
foreign import getTeamDetails         :: forall e. TeamDetailsQuery        -> (TeamDetailsResponse        -> Eff e Unit) -> FedgerEff Unit

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