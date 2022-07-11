# GtDatabaseVisualizer

Interactive tool to visualize table details & foreign key relationships in SQL databases.

# Installation

```Smalltalk
[ EpMonitor current disableDuring: [ Metacello new
   baseline: 'GtDatabaseVisualizer';
   repository: 'github://botwhytho/GtDatabaseVisualizer:main/src';   onConflictUseLoaded;
   load. ]] forkAt: 29 named: #GtDatabaseVisualizer
   ```