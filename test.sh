#!/bin/sh

# ==========================================
# INT142 Individual Practice Repo Test Script
# Score-based validation (Total 100 points)
# ==========================================

TOTAL=0
FAILED=0

sep () {
  printf "\n---------------------------------------------------\n"
}

add_score () {
  # $1 = points
  TOTAL=$((TOTAL + $1))
}

pass () {
  echo "✅ $1"
}

fail () {
  echo "❌ $1"
  FAILED=1
}

require_git_repo () {
  if [ ! -d ".git" ]; then
    fail "Not a git repository (missing .git). Run this script at repo root."
    exit 1
  fi
}

file_exists () {
  # $1 = path
  [ -f "$1" ]
}

dir_exists () {
  # $1 = path
  [ -d "$1" ]
}

contains_text () {
  # $1 = file, $2 = fixed string
  # return 0 if contains
  grep -Fq "$2" "$1" 2>/dev/null
}

contains_regex () {
  # $1 = file, $2 = regex
  grep -Eq "$2" "$1" 2>/dev/null
}

has_commit_subject () {
  # $1 = fixed string to search in commit subject
  git log --format='%s' 2>/dev/null | grep -Fq "$1"
}

has_commit_subject_regex () {
  # $1 = regex
  git log --format='%s' 2>/dev/null | grep -Eq "$1"
}

# ---------------------------
# Test 1: Required files (30)
# ---------------------------
test_required_files () {
  sep
  echo "Test 1: Required files and folders (30 Points)"

  P=0

  if file_exists "README.md"; then
    pass "README.md exists"
    P=$((P + 5))
  else
    fail "README.md missing"
  fi

  if file_exists "index.html"; then
    pass "index.html exists"
    P=$((P + 5))
  else
    fail "index.html missing"
  fi

  if file_exists "index-template.html"; then
    pass "index-template.html exists"
    P=$((P + 5))
  else
    fail "index-template.html missing"
  fi

  if file_exists "COLLABORATORS.md"; then
    pass "COLLABORATORS.md exists"
    P=$((P + 5))
  else
    fail "COLLABORATORS.md missing"
  fi

  if file_exists ".github/workflows/classroom.yml"; then
    pass ".github/workflows/classroom.yml exists"
    P=$((P + 5))
  else
    fail ".github/workflows/classroom.yml missing"
  fi

  if dir_exists "reflog"; then
    pass "reflog/ directory exists"
    P=$((P + 5))
  else
    fail "reflog/ directory missing"
  fi

  add_score "$P"
  echo " = Score gained: $P/30"
}

# ---------------------------------------
# Test 2: README alignment & keywords (20)
# ---------------------------------------
test_readme_content () {
  sep
  echo "Test 2: README content alignment (20 Points)"

  if ! file_exists "README.md"; then
    fail "README.md missing; cannot check content"
    return
  fi

  P=0

  # Check it looks like assignment-style parts
  if contains_regex "README.md" "Part[[:space:]]*[0-9]+"; then
    pass "README contains Part sections"
    P=$((P + 5))
  else
    fail "README should contain Part sections (e.g., 'Part 1', 'Part 2', ...)"
  fi

  # Check automation described (remote overwrite)
  if contains_regex "README.md" "Automat(ed|ion)|automated|remote update|overwrit"; then
    pass "README mentions automation / remote update simulation"
    P=$((P + 5))
  else
    fail "README should mention automation/remote update simulation"
  fi

  # Check evidence described
  if contains_regex "README.md" "reflog/|Evidence"; then
    pass "README mentions reflog evidence"
    P=$((P + 5))
  else
    fail "README should mention reflog/ evidence"
  fi

  # Check commit keyword section exists
  if contains_regex "README.md" "Commit Message Keywords|commit message keywords"; then
    pass "README contains 'Commit Message Keywords' section"
    P=$((P + 5))
  else
    fail "README should contain 'Commit Message Keywords' section"
  fi

  add_score "$P"
  echo " = Score gained: $P/20"
}

# -----------------------------------------
# Test 3: Commit keywords present in history (25)
# -----------------------------------------
test_commit_keywords () {
  sep
  echo "Test 3: Commit keywords in git history (25 Points)"

  P=0

  # Required keywords (based on your README spec)
  # You can edit these to match your README exactly.
  K1="Feature: Update index.html content"
  K2="Conflict: Modify same line in index.html"
  K3="Merge: Resolve conflict on index.html"
  K4="Recovery: Restore previous state"
  K5="History: Reorganize commits"
  K6="Evidence: Add reflog records"
  K7="auto: simulate remote collaborator update"

  if has_commit_subject "$K1"; then pass "Found commit: $K1"; P=$((P + 4)); else fail "Missing commit: $K1"; fi
  if has_commit_subject "$K2"; then pass "Found commit: $K2"; P=$((P + 4)); else fail "Missing commit: $K2"; fi
  if has_commit_subject "$K3"; then pass "Found commit: $K3"; P=$((P + 4)); else fail "Missing commit: $K3"; fi
  if has_commit_subject "$K4"; then pass "Found commit: $K4"; P=$((P + 4)); else fail "Missing commit: $K4"; fi
  if has_commit_subject "$K5"; then pass "Found commit: $K5"; P=$((P + 4)); else fail "Missing commit: $K5"; fi
  if has_commit_subject "$K6"; then pass "Found commit: $K6"; P=$((P + 3)); else fail "Missing commit: $K6"; fi
  if has_commit_subject "$K7"; then pass "Found commit: $K7"; P=$((P + 2)); else fail "Missing commit: $K7"; fi

  add_score "$P"
  echo " = Score gained: $P/25"
}

# -------------------------------------------------
# Test 4: Workflow contains overwrite + collaborator update (15)
# -------------------------------------------------
test_workflow_behavior () {
  sep
  echo "Test 4: Workflow behavior check (15 Points)"

  WF=".github/workflows/classroom.yml"
  if ! file_exists "$WF"; then
    fail "Workflow missing; cannot check automation"
    return
  fi

  P=0

  # Check it targets index.html
  if contains_regex "$WF" "index\\.html"; then
    pass "Workflow references index.html"
    P=$((P + 5))
  else
    fail "Workflow should reference index.html"
  fi

  # Check it references COLLABORATORS.md
  if contains_regex "$WF" "COLLABORATORS\\.md"; then
    pass "Workflow references COLLABORATORS.md"
    P=$((P + 4))
  else
    fail "Workflow should reference COLLABORATORS.md"
  fi

  # Check it commits (heuristic: git commit)
  if contains_regex "$WF" "git[[:space:]]+commit"; then
    pass "Workflow contains a commit step"
    P=$((P + 3))
  else
    fail "Workflow should create a commit"
  fi

  # Check it pushes back (heuristic: git push)
  if contains_regex "$WF" "git[[:space:]]+push"; then
    pass "Workflow contains a push step"
    P=$((P + 3))
  else
    fail "Workflow should push changes back to the repo"
  fi

  add_score "$P"
  echo " = Score gained: $P/15"
}

# ------------------------------------
# Test 5: Reflog evidence files (10)
# ------------------------------------
test_reflog_evidence () {
  sep
  echo "Test 5: Reflog evidence files (10 Points)"

  if ! dir_exists "reflog"; then
    fail "reflog/ missing; cannot check evidence"
    return
  fi

  P=0

  # Minimum required evidence files
  if file_exists "reflog/reflog_HEAD.txt"; then pass "reflog_HEAD.txt exists"; P=$((P + 4)); else fail "Missing reflog/reflog_HEAD.txt"; fi
  if contains_regex "reflog/reflog_HEAD.txt" "Evidence:|Generated:" 2>/dev/null; then pass "reflog_HEAD.txt has header"; P=$((P + 1)); else fail "reflog_HEAD.txt should include a header"; fi

  # At least one branch reflog file
  BRCOUNT=$(ls reflog 2>/dev/null | grep -E "^reflog_.*\.txt$" | grep -v "reflog_HEAD\.txt" | wc -l | tr -d ' ')
  if [ "$BRCOUNT" -ge 1 ]; then
    pass "Found branch reflog files: $BRCOUNT"
    P=$((P + 3))
  else
    fail "No branch reflog files found (expected at least 1)"
  fi

  # Evidence index file
  if file_exists "reflog/README.md"; then pass "reflog/README.md exists"; P=$((P + 2)); else fail "Missing reflog/README.md"; fi

  add_score "$P"
  echo " = Score gained: $P/10"
}

# ---------------
# Main
# ---------------
require_git_repo

printf "\n===================================================\n"
echo "INT142 Individual Practice Repo - Validation Script"
echo "==================================================="

test_required_files
test_readme_content
test_commit_keywords
test_workflow_behavior
test_reflog_evidence

sep
echo "Final Score: $TOTAL/100"

if [ "$FAILED" -eq 1 ]; then
  echo "Result: ❌ NEEDS FIXES"
  exit 1
else
  echo "Result: ✅ PASS"
  exit 0
fi
