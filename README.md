# INT142 Software Development Tools  
## Individual Practice – Source Control, Collaboration, and Automation Simulation

---

## Overview

This repository demonstrates a complete simulation of distributed software development  
performed by an individual developer.

Collaborative scenarios are reproduced through structured development workflows,  
task tracking, conflict handling, history recovery, and automated remote updates.

Automated processes behave as a simulated remote contributor, modifying repository  
content after updates are submitted. This ensures that local and remote states may  
diverge and must be synchronized and reconciled.

All activities reflect realistic repository management conditions in a collaborative  
environment.

---

## Repository Structure

- **index.html**  
  Main working file used for feature development, integration testing, conflict simulation,  
  and automated remote overwriting.

- **index-template.html**  
  Reference file used for file state management and restoration practice.

- **COLLABORATORS.md**  
  Records ownership and simulated collaborator information.

- **reflog/**  
  Contains repository activity records showing history movements, recovery events,  
  and integration changes.

- **.github/workflows/classroom.yml**  
  Defines automated repository behavior and validation processes.

---

## Part 1 – Repository Setup and Ownership

### Objective
Establish structured responsibility and task ownership.

### Instructions
1. Record repository ownership information.
2. Define simulated collaborator identity.
3. Track task progress until completion.
4. Integrate ownership information into the main codebase.

---

## Part 2 – Feature Development

### Objective
Simulate isolated development and controlled integration.

### Instructions
1. Modify repository content in an isolated development path.
2. Validate changes before integration.
3. Integrate completed work into the main codebase.
4. Confirm repository stability after integration.

---

## Part 3 – Conflict Simulation and Resolution

### Objective
Understand how conflicting changes occur and are resolved.

### Instructions
1. Apply different modifications to the same content from separate development paths.
2. Attempt to combine the changes.
3. Analyze conflicting content.
4. Resolve the conflict to produce the intended final version.

---

## Part 4 – Change Recovery

### Objective
Restore repository state after unintended changes.

### Instructions
1. Introduce unintended modifications.
2. Restore previous file content.
3. reverse completed changes when necessary.
4. Confirm repository integrity after recovery.

---

## Part 5 – History Restructuring

### Objective
Maintain a clean and logical development timeline.

### Instructions
1. Reorganize development history.
2. Resolve integration issues during restructuring.
3. Confirm that the final history reflects intended development order.

---

## Part 6 – Remote Update Simulation

### Objective
Simulate independent remote repository changes.

### Instructions
1. Submit updates to the repository.
2. Observe automated remote modifications.
3. Synchronize local work with remote changes.
4. Resolve differences after synchronization.

---

## Part 7 – Task Tracking

### Objective
Simulate project management workflow.

### Instructions
1. Define structured work items.
2. Track progress through defined states.
3. Link completed work to corresponding tasks.

---

## Part 8 – Automated Repository Behavior

### Objective
Observe automated modifications applied to repository content.

### Behavior

After updates are submitted, an automated process performs the following actions:

- Overwrites `index.html` with updated content
- Updates `COLLABORATORS.md` with remote contributor activity
- Creates a new repository commit representing remote changes

This simulates an external contributor modifying repository content independently.

---

## Part 9 – Evidence Collection

### Objective
Maintain verifiable records of repository activity.

### Evidence Includes

- branch movements
- integration events
- conflict resolution
- history recovery
- automated remote updates

All records are stored in the `reflog/` directory.

---

## Commit Message Keywords

Repository activity is tracked using structured commit message identifiers.

Use the following formats:

- Feature development  
  `Feature: Update index.html content`

- Conflict creation  
  `Conflict: Modify same line in index.html`

- Conflict resolution  
  `Merge: Resolve conflict on index.html`

- Recovery operations  
  `Recovery: Restore previous state`

- History restructuring  
  `History: Reorganize commits`

- Evidence recording  
  `Evidence: Add reflog records`

- Automated remote update  
  `auto: simulate remote collaborator update`

If a commit message does not match the required format, it must be corrected  
to maintain consistent activity tracking.

---

## Validation and Inspection

Repository activity can be verified through:

- workflow execution records
- automated commit history
- updated repository files
- preserved activity logs

Successful execution confirms synchronization between local development,  
remote automation, and repository history.

---

## Summary

This repository represents a full simulation of collaborative software development  
in a distributed environment performed individually.

The practice demonstrates:

- structured development workflow  
- controlled integration  
- conflict detection and resolution  
- repository recovery  
- history restructuring  
- remote synchronization  
- automated modification  
- activity verification  

All repository behavior reflects realistic multi-contributor development conditions.
