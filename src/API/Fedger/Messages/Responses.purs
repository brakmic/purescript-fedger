module API.Fedger.Messages.Responses where

import Prelude                      (bind)
import API.Fedger.Messages.Partials (..)

data FundingDetailsResponse = FundingDetailsResponse {
  "name"           :: String,
  "domain"         :: String,
  "amount_total"   :: Number,
  "currency"       :: String,
  "rounds"         :: Array Round
}

data FundingStatusResponse = FundingStatusResponse {
  "name"         :: String,
  "domain"       :: String,
  "amount_total" :: Number,
  "currency"     :: String,
  "status"       :: String
}

data FundingsResponse = FundingsResponse {
  "domain"     :: String,
  "total_fund" :: Number,
  "currency"   :: String,
  "cursor"     :: Number,
  "fundings"   :: Array String
}

data CompanyInsightsResponse = CompanyInsightsResponse {
  "cursor" :: Number,
  "nodes"  :: Array String
}

data InvestorsResponse = InvestorsResponse {
  "domain"    :: String,
  "name"      :: String,
  "cursor"    :: Number,
  "investors" :: Array Investor
}

data LocationsResponse = LocationsResponse {
   "name"       :: String,
   "cursor"     :: Number,
   "nextCursor" :: Number,
   "domain"     :: String,
   "locations"  :: Array Location
}

data PeersResponse = PeersResponse {
  "domain" :: String,
  "peers"  :: Array Peer
}

data PortfolioCompaniesResponse = PortfolioCompaniesResponse {
  "domain"    :: String,
  "name"      :: String,
  "cursor"    :: Number,
  "portfolio" :: Array PortfolioEntry
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
  "cursor" :: Number,
  "team"   :: Array TeamMember
}

data LogoResponse = LogoResponse {
  binary :: String
}
