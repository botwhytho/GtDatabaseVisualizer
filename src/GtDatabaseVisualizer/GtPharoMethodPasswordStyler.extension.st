Extension { #name : #GtPharoMethodPasswordStyler }

{ #category : #'*GtDatabaseVisualizer' }
GtPharoMethodPasswordStyler >> sqlDatabasePassword [
	<gtMethodPassword>
	^ URLPasswordDefinition new
		selector: #fromConnectionString:;
		position: 1
]

{ #category : #'*GtDatabaseVisualizer' }
GtPharoMethodPasswordStyler >> sqlDatabasePasswordTwoArguments [
	<gtMethodPassword>
	^ URLPasswordDefinition new
		selector: #fromConnectionString:withShortName:;
		position: 1
]
