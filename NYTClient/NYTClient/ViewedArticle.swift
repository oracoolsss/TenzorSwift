//
//  ViewedArticle.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation

struct MediaMetadata: Decodable {
  let format: String
  let height: Int
  let url: String
  let width: Int
}

struct Media: Decodable {
  let approved_for_syndication: Bool
  let caption: String
  let copyright: String
  //vajno
  let media_metadata: [MediaMetadata]
  let subtype: String
  let type: String
  
  enum CodingKeys: String, CodingKey {
    case media_metadata = "media-data"
    case approved_for_syndication
    case caption
    case copyright
    case subtype
    case type
  }
}

struct ViewedArticle: Decodable {
  let abstract: String?
  let adx_keywords: String?
  let asset_id: Int?
  let byline: String?
  let column: String?
  let des_facet: [String]?
  let geo_facet: [String]?
  let id: Int?
  let media: [Media]?
  let org_facet: [String]?
  let per_facet: [String]?
  let published_date: String?
  let section: String?
  let source: String?
  let title: String?
  let type: String?
  let uri: String?
  let url: String?
  let views: String?
}

struct ViewedArticles: Decodable {
  let viewedArticles: [ViewedArticle]
}

struct vaResponseBody: Decodable {
  let copyright: String
  let num_results: Int
  let results: [ViewedArticle]
}
