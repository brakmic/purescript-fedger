module API.Fedger.Messages.Responses where

import Prelude                      (bind)
import Data.List                    (List)
import API.Fedger.Messages.Partials (..)

data FundingDetailsResponse = FundingDetailsResponse {
  "name"           :: String,
  "domain"         :: String,
  "amount_total"   :: Int,
  "currency"       :: String,
  "rounds"         :: List Round
}

data FundingStatusResponse = FundingStatusResponse {
  "name"         :: String,
  "domain"       :: String,
  "amount_total" :: Int,
  "currency"     :: String,
  "status"       :: String
}

data FundingsResponse = FundingsResponse {
  "domain"     :: String,
  "total_fund" :: Int,
  "currency"   :: String,
  "cursor"     :: Int,
  "fundings"   :: List String
}

data CompanyInsightsResponse = CompanyInsightsResponse {
  "cursor" :: Int,
  "nodes"  :: List String
}

data InvestorsResponse = InvestorsResponse {
  "domain"    :: String,
  "name"      :: String,
  "cursor"    :: Int,
  "investors" :: List Investor
}

data LocationsResponse = LocationsResponse {
   "name"       :: String,
   "cursor"     :: Int,
   "nextCursor" :: Int,
   "domain"     :: String,
   "locations"  :: List Location
}

data PeersResponse = PeersResponse {
  "domain" :: String,
  "peers"  :: List Peer
}

data PortfolioCompaniesResponse = PortfolioCompaniesResponse {
  "domain"    :: String,
  "name"      :: String,
  "cursor"    :: Int,
  "portfolio" :: List PortfolioEntry
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

data TeamDetailsResponse = TeamDetailsResponse {
  "domain" :: String,
  "name"   :: String,
  "cursor" :: Int,
  "team"   :: List TeamMember
}

data LogoResponse = LogoResponse {
  binary :: String
}
