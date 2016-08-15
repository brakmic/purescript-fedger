module API.Fedger.Messages.Responses where

import Data.List                    (List)
import API.Fedger.Messages.Partials

-- | ***************** COMPANY API **************************

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

-- | ************************* DISCOVER API ***********************

data DiscoveryResponse = DiscoveryResponse {
  "data" :: DiscoveryData
}

data DiscoveryCompaniesResponse = DiscoveryCompaniesResponse {
  "cursor"      :: Int,
  "total_count" :: Int,
  "data"        :: List DiscoveryCompaniesEntry
}

data DiscoveryVerticesResponse = DiscoveryVerticesResponse {
  "cursor"      :: Int,
  "total_count" :: Int,
  "data"        :: List Vertice
}

-- | ************************** GEO API ***************************

data GeoLocatedCompaniesResponse = GeoLocatedCompaniesResponse {
  "cursor"    :: Int,
  "companies" :: List GeoLocatedCompany
}

data GeoLocatedFundingsResponse = GeoLocatedFundingsResponse {
  "cursor"   :: Int,
  "fundings" :: List GeoLocatedFunding
}

-- | ************************** NEWS API **************************

data LatestFundingsResponse = LatestFundingsResponse {
  "date_reference"  :: Number,
  "fundings"        :: List LatestFunding
}

-- | ************************** STATS API *************************

data StatsFundingsResponse = StatsFundingsResponse {
  "type"     :: String,
  "year"     :: Int,
  "currency" :: String,
  "count"    :: Int,
  "total"    :: Number,
  "min"      :: Number,
  "max"      :: Number,
  "mean"     :: Number,
  "stddev"   :: Number
}

-- | ************************* TAGGED API *************************

data TaggedCompaniesResponse = TaggedCompaniesResponse {
  "cursor" :: Int,
  "companies" :: List TaggedCompany
}

data TaggedFundingsResponse = TaggedFundingsResponse {
  "cursor"   :: Int,
  "fundings" :: List TaggedFunding
}