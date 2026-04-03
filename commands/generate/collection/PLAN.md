# Meteor Collection Scaffolding Command

**Status:** Planned  
**Related Feature:** meteor-mongodb-development.md  
**Priority:** Medium

## Purpose

Generate Meteor collection boilerplate with schema, indexes, publications, and validation.

## Command Signature

```
vulcan generate collection <name> [--fields <field-spec>] [--project <path>]
```

## What It Should Do

1. Create collection file with schema
2. Generate publication for collection
3. Add collection to server startup
4. Create client subscription stub
5. Generate sample collection methods (insert, update, remove with validation)
6. Add to imports if in Meteor project

## Inputs

- Collection name
- Field specifications (e.g., title:String,count:Number,tags:Array)
- Target project path

## Outputs

- `/imports/api/collections/{name}.js` - Collection definition
- `/imports/api/publications/{name}.js` - Publications
- `/imports/api/methods/{name}.js` - Mutation methods
- Updated imports in main app file

## Implementation Notes

- Follow Meteor best practices for collections
- Include SimpleSchema validation
- Pre-configure common indexes
- Support denormalization patterns
