module API.Fedger.Messages.Queries where

data FundingDetailsQuery = FundingDetailsQuery {
  domain :: String,
  apikey :: String
}

data FundingStatusQuery = FundingStatusQuery {
  domain :: String,
  apikey :: String
}

data FundingsQuery = FundingsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Number
}

data CompanyInsightsQuery = CompanyInsightsQuery {
  domain  :: String,
  apikey  :: String,
  classes :: String,
  cursor  :: Number
}

data CompanySnapshotQuery = CompanySnapshotQuery {
  domain :: String,
  apikey :: String
}

data InvestorsQuery = InvestorsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Number
}

data LocationsQuery = LocationsQuery {
  domain :: String,
  apikey :: String,
  cursor :: String
}

data PeersQuery = PeersQuery {
  domain :: String,
  apikey :: String
}

data PortfolioCompaniesQuery = PortfolioCompaniesQuery {
  domain :: String,
  apikey :: String,
  cursor :: Number
}

data TeamDetailsQuery = TeamDetailsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Number
}

data LogoQuery = LogoQuery {
  domain :: String,
  apikey :: String
}