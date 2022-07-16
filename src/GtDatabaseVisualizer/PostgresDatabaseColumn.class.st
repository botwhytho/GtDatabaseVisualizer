Class {
	#name : #PostgresDatabaseColumn,
	#superclass : #DatabaseColumn,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseColumn >> populateColumnAtributes [
	| attributeNames columnAttributes |
	columnAttributes := self getColumnAttributes.
	attributeNames := columnAttributes columnNames.
	columnAttributes data
		do: [ :aColumnAttributeRow | 
			attributeNames
				do: [ :aColumnAttribute | 
					self attributes
						add: (PostgresDatabaseColumnAttribute new
								name: aColumnAttribute;
								value: (aColumnAttributeRow at: (attributeNames indexOf: aColumnAttribute));
								client: self client;
								column: self) ] ]
]

{ #category : #accessing }
PostgresDatabaseColumn >> query [
	^ query
		ifNil: [ query := 'SELECT ordinal_position, column_default, is_nullable, data_type
FROM information_schema.columns
WHERE table_schema = $1
AND table_name = $2
AND column_name = $3' ]
]
