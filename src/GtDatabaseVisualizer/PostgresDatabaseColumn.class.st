Class {
	#name : #PostgresDatabaseColumn,
	#superclass : #DatabaseColumn,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseColumn >> populateColumnAtributes [
	| allColumnAttributes attributesInThisColumn |
	self valuable: (MessageSend receiver: self table schema selector: #allColumns).
	allColumnAttributes := self getEntities.
	attributesInThisColumn := allColumnAttributes
			select: [ :column | column table_name = self table name and: [ column column_name = self name ] ].
	attributesInThisColumn
		do: [ :aColumnAttributeRow | 
			(aColumnAttributeRow associations
				reject: [ :each | #('table_name' 'column_name') includes: each key ])
				do: [ :aColumnAttribute | 
					self attributes
						add: (PostgresDatabaseColumnAttribute new
								name: aColumnAttribute key;
								value: aColumnAttribute value;
								client: self client;
								column: self) ] ]
]
