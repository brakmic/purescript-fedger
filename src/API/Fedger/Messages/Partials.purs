module API.Fedger.Messages.Partials where

data Investor = Investor {
  "type"   :: String,
  "name"   :: String,
  "slug"   :: String,
  "domain" :: String
}

data Round = Round {
  "date"      :: Number,
  "amount"    :: Number,
  "currency"  :: String,
  "round"     :: String,
  "investors" :: Array Investor
}

data Location = Location {
  "city"        :: String,
  "country"     :: String,
  "iso_country" :: String
}

data Peer = Peer {
  "name" :: String,
  "rank" :: Number,
  "sim"  :: Number,
  "url"  :: String
}

data PortfolioEntry = PortfolioEntry {
  "name"   :: String,
  "domain" :: String,
  "slug"   :: String
}

data TeamMember = TeamMember {
  "urlAngellist" :: String,
  "fullName"     :: String,
  "urlTwitter"   :: String,
  "urlLinkedIn"  :: String,
  "role"         :: String,
  "lead"         :: Number
}