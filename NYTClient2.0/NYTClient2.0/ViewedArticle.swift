//
//  ViewedArticle.swift
//  NYTClient2.0
//
//  Created by oracool on 16/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation


struct vaResponseBody: Codable {
  let status, copyright: String
  let numResults: Int
  let results: [ViewedArticle]
  
  enum CodingKeys: String, CodingKey {
    case status, copyright
    case numResults = "num_results"
    case results
  }
}

// MARK: - Result
struct ViewedArticle: Codable {
  let url: String
  let adxKeywords: String
  let column: String?
  let section, byline, type, title: String
  let abstract, publishedDate, source: String
  let id, assetID, views: Int
  let desFacet, orgFacet: [String]
  let perFacet: [String]
  let geoFacet: [String]
  let media: [Media]
  let uri: String
  
  enum CodingKeys: String, CodingKey {
    case url
    case adxKeywords = "adx_keywords"
    case column, section, byline, type, title, abstract
    case publishedDate = "published_date"
    case source, id
    case assetID = "asset_id"
    case views
    case desFacet = "des_facet"
    case orgFacet = "org_facet"
    case perFacet = "per_facet"
    case geoFacet = "geo_facet"
    case media, uri
  }
}

// MARK: - Media
struct Media: Codable {
  let type, subtype, copyright: String
  let caption: String
  let approvedForSyndication: Int
  let mediaMetadata: [MediaMetadatum]
  
  enum CodingKeys: String, CodingKey {
    case type, subtype, caption, copyright
    case approvedForSyndication = "approved_for_syndication"
    case mediaMetadata = "media-metadata"
  }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
  let url: String
  let format: String
  let height, width: Int
}
