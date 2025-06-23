// XMLWorkflowParser.swift

import Foundation

class XMLWorkflowParser: NSObject, XMLParserDelegate {
    private var currentElement = ""
    private var workflows: [WorkflowDetailModel] = []
    private var currentWorkflow: WorkflowDetailModel?
    
    private var currentWorkflowID = ""
    private var currentWorkflowName = ""
    private var currentGroupID = ""
    private var currentGroupName = ""

    func parse(workflows data: Data) -> [WorkflowDetailModel] {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
        return workflows
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if elementName == "workflow" {
            currentWorkflowID = ""
            currentWorkflowName = ""
            currentGroupID = ""
            currentGroupName = ""
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        switch currentElement {
        case "workflow_id":
            currentWorkflowID += trimmed
        case "workflow_name":
            currentWorkflowName += trimmed
        case "group_id":
            currentGroupID += trimmed
        case "group_name":
            currentGroupName += trimmed
        default:
            break
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "workflow" {
            let workflow = WorkflowDetailModel(
                workflowID: currentWorkflowID,
                workflowName: currentWorkflowName,
                groupID: currentGroupID,
                groupName: currentGroupName,
                indexingQueue: 0,
                qualityAssuranceQueue: 0,
                rejectedQueue: 0
            )
            workflows.append(workflow)
        }
    }
}
