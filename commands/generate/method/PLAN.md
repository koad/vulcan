# Meteor Method Scaffolding Command

**Status:** Planned  
**Related Feature:** meteor-mongodb-development.md  
**Priority:** Medium

## Purpose

Generate Meteor method boilerplate with validation, error handling, and type checking.

## Command Signature

```
vulcan generate method <name> [--args <spec>] [--collection <collection>] [--project <path>]
```

## What It Should Do

1. Create server method with basic structure
2. Add validation/schema checking
3. Include error handling and try/catch
4. Add logging/debugging
5. Include JSDoc comments
6. Reference collection operations if specified
7. Create test stub

## Inputs

- Method name
- Argument specifications
- Related collection (optional)
- Target project path

## Outputs

- `/imports/api/methods/{name}.js` - Method implementation
- Test file stub
- Integration guide

## Implementation Notes

- Follow Meteor security best practices
- Include rate limiting hooks
- Support async/await patterns
- Type checking with validation libraries
