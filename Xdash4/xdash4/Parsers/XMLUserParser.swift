// XMLUserParser.swift

import Foundation

class XMLUserParser: NSObject, XMLParserDelegate {
    private var currentElement = ""
    private var userID = ""
    private var userName = ""
    private var apiKey = ""

    private var completionHandler: ((User?) -> Void)?
    
    func parse(data: Data) -> User? {
        var parsedUser: User?
        self.completionHandler = { user in
            parsedUser = user
        }
        
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        
        return parsedUser
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        switch currentElement {
        case "user_id":
            userID += trimmed
        case "user_name":
            userName += trimmed
        case "api_key":
            apiKey += trimmed
        default:
            break
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        let user = User(userID: userID, userName: userName, apiKey: apiKey)
        completionHandler?(user)
    }
}
