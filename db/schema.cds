namespace sap.ui.riskmanagement;
//Use namespaces if your models might be reused in other projects

using { managed } from '@sap/cds/common';

  entity Risks : managed {
    key ID      : Integer;
    title       : String(100);
    prio        : String(5);
    descr       : String;
    miti        : Association to Mitigations;
    impact      : Integer;
    criticality : Integer;
  }

  entity Mitigations : managed {
    key ID       : Integer;
    description  : String;
    owner        : String;
    timeline     : String;
    risks        : Association to many Risks on risks.miti = $self;
  }

// It creates two entities in the namespace sap.ui.riskmanagement: Risks and Mitigations. 
//Each of them has a key called ID and several other properties.
// A Risk has a Mitigation and, therefore, the property miti has an association to exactly one Mitigation. 
//A Mitigation in turn can be used for many Risks, so it has a “to many” association. 
//The key is automatically filled by the CAP server, which is exposed to the user of the service with the annotation @(Core.Computed : true).

// Notice how the CAP server reacted to dropping the file. 
//It now tells you that it has a model but there are no service definitions yet and, thus, it still can’t serve anything. 
//Next, you add a service definition.