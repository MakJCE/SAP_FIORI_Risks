using RiskService from './risk-service';

//Section 1 -- Name labels of entities

annotate RiskService.Risks with {
	ID       @title: 'id'; //labels in form fields and column headers
	title       @title: 'Title'; //labels in form fields and column headers
	prio        @title: 'Priority';
	descr       @title: 'Description';
	miti        @title: 'Mitigation';
	impact      @title: 'Impact';
}

annotate RiskService.Mitigations with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'Description';
	owner        @title: 'Owner';
	timeline     @title: 'Timeline';
	risks        @title: 'Risks';
}

//Section 2 - To set configurations of a table and single page
annotate RiskService.Risks with @(
	UI: {
		HeaderInfo: { //defines the header info
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title          : {
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: descr
			}
		},
		SelectionFields: [prio], //properties to make searchable
		LineItem: [ //columns and their order in table
			{Value: title},
			{Value: miti_ID},
			{
				Value: prio,
				Criticality: criticality //criticality name is setted in bussines logic
			},
			{
				Value: impact,
				Criticality: criticality
			}
		],
		Facets: [ //Single Page confs
		// a single facet referenceFacet
			{$Type: 'UI.ReferenceFacet', 
			Label: 'Main', 
			Target: '@UI.FieldGroup#Main'}
		], //Shows data as a form
		FieldGroup#Main: {
			Data: [
				{Value: miti_ID},
				{
					Value: prio,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				}
			]
		}
	},
) {

};
//Mitigation field section in Risk
annotate RiskService.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: { //Add a selectable list
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}
