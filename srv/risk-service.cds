using {sap.ui.riskmanagement as my} from '../db/schema';
//Services exposed by your app are rarely reused, so rarely need namespaces

// @path: 'service/risk'
// service RiskService {
//   entity Risks as projection on my.Risks;
//     annotate Risks with @odata.draft.enabled;
//   entity Mitigations as projection on my.Mitigations;
//     annotate Mitigations with @odata.draft.enabled;
// }

@path: 'service/risk'
service RiskService {
    entity Risks as projection on my.Risks;
    annotate Risks with @odata.draft.enabled;
    entity Mitigations as projection on my.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
}
// @(restrict : [
//             {
//                 grant : [ 'READ' ],
//                 to : [ 'RiskViewer' ]
//             },
//             {
//                 grant : [ '*' ],
//                 to : [ 'RiskManager' ]
//             }
//         ])
