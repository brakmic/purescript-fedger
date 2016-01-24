module API.Fedger.Messages.Queries where

import Data.Maybe (..)
import Data.List  (List)

-- | ******************* COMPANY API *********************************

data FundingDetailsQuery = FundingDetailsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data FundingStatusQuery = FundingStatusQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data FundingsQuery = FundingsQuery {
  domain      :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data CompanyInsightsQuery = CompanyInsightsQuery {
  domain      :: String,
  classes     :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data CompanySnapshotQuery = CompanySnapshotQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data InvestorsQuery = InvestorsQuery {
  domain      :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data LocationsQuery = LocationsQuery {
  domain      :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data PeersQuery = PeersQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data PortfolioCompaniesQuery = PortfolioCompaniesQuery {
  domain      :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data TeamDetailsQuery = TeamDetailsQuery {
  domain      :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data LogoQuery = LogoQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

-- | ************************* DISCOVER API ************************

data DiscoveryQuery = DiscoveryQuery {
  s           :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data DiscoveryCompaniesQuery = DiscoveryCompaniesQuery {
  s           :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

data DiscoveryVerticesQuery = DiscoveryVerticesQuery {
  s           :: String,
  cursor      :: Int,
  apikey      :: String,
  crossDomain :: Boolean
}

-- | ************************** GEO API ****************************

data GeoLocatedCompaniesQuery = GeoLocatedCompaniesQuery {
  "country_code" :: String,
  "cities"       :: List String,
  "cursor"       :: Int,
  "apikey"       :: String,
  "crossDomain"  :: Boolean
}

data GeoLocatedFundingsQuery = GeoLocatedFundingsQuery {
  "country_code" :: String,
  "cities"       :: List String,
  "range_from"   :: Int,
  "range_to"     :: Int,
  "cursor"       :: Int,
  "apikey"       :: String,
  "crossDomain"  :: Boolean
}

-- | ************************** NEWS API ***************************

data LatestFundingsQuery = LatestFundingsQuery {
  "apikey"       :: String,
  "crossDomain"  :: Boolean
}

-- | ************************** STATS API **************************

data StatsFundingsQuery = StatsFundingsQuery {
  "year"        :: Int,
  "month"       :: Maybe Int,
  "country"     :: Maybe String,
  "tag"         :: Maybe String,
  "apikey"      :: String,
  "crossDomain" :: Boolean
}

-- | ************************** TAGGED API *************************

data TaggedCompaniesQuery = TaggedCompaniesQuery {
  "tags"        :: String,
  "isJoin"      :: Maybe Boolean,
  "cursor"      :: Maybe Int,
  "apikey"      :: String,
  "crossDomain" :: Boolean
}

data TaggedFundingsQuery = TaggedFundingsQuery {
  "tags"       :: String,
  "range_from" :: Maybe Number,
  "range_to"   :: Maybe Number,
  "isJoin"     :: Maybe Boolean,
  "cursor"     :: Maybe Int,
  "apikey"      :: String,
  "crossDomain" :: Boolean
}