Class {
	#name : #PostgresDatabaseTable,
	#superclass : #DatabaseTable,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseTable class >> columnClass [
	^ PostgresDatabaseColumn
]
