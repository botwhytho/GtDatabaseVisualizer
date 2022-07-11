Class {
	#name : #PostgresDatabaseTable,
	#superclass : #DatabaseTable,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseTable >> populateColumns [
	| allColumns columnsInThisTable |
	self valuable: (MessageSend receiver: self schema selector: #allColumns).
	allColumns := self getEntities.
	columnsInThisTable := allColumns select: [ :column | column table_name = self name ].
	columnsInThisTable
		do: [ :aColumn | 
			self columns
				add: (PostgresDatabaseColumn new
						name: aColumn column_name;
						client: self client;
						table: self;
						populateColumnAtributes) ]
]
