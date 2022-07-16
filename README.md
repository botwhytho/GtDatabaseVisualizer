# GtDatabaseVisualizer

Interactive tool to visualize table details & foreign key relationships in SQL databases in [Glamorous Toolkit](https://gtoolkit.com/)

# Installation

```Smalltalk
[ EpMonitor current disableDuring: [ Metacello new
   baseline: 'GtDatabaseVisualizer';
   repository: 'github://botwhytho/GtDatabaseVisualizer:main/src';
   onConflictUseLoaded;
   load. ]] forkAt: 29 named: #GtDatabaseVisualizer
   ```
   
   # Usage
   
   To quickly & interactively visualize foreign key relationships in your database (currently only Postgres supported, but was designed with extensibility in mind), run something like the command below. This will try to import all metadata for databases, schemas, tables, columns, foreign keys & other column attributes, no actual table data is currently loaded. When you click on table headers you go to the underlying table, this is NOT a static UML diagram.
   
   This is currently alpha level software built during a weekend, with no error handling. If this is useful to you please help me make it better.
   
   ```Smalltalk
   GtDatabaseVisualizer postgres fromConnectionString: 'psql://postgres:*********@localhost:5433/dvdrental' withShortName: 'DVD Rental'
   ``` 
