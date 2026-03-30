#!/bin/bash
echo "=== SHOPIFY THEME VALIDATION ==="

cd "$(dirname "$0")/.."

# 1. All JSON files valid
echo ""
echo "--- JSON Validity ---"
for f in templates/*.json sections/*.json config/*.json; do
  [ -f "$f" ] && python3 -m json.tool "$f" > /dev/null 2>&1 && echo "OK $f" || echo "INVALID JSON: $f"
done

# 2. Every section type has a matching .liquid file AND is in order array
echo ""
echo "--- Section Wiring ---"
python3 -c "
import json, os, glob
errors = []
for tf in glob.glob('templates/*.json'):
    with open(tf) as f:
        data = json.load(f)
    for key, sec in data.get('sections', {}).items():
        stype = sec.get('type', '')
        if not os.path.exists(f'sections/{stype}.liquid'):
            errors.append(f'{tf}: type \"{stype}\" has no matching .liquid file')
        if key not in data.get('order', []):
            errors.append(f'{tf}: key \"{key}\" NOT in order array')
if errors:
    for e in errors: print(f'ISSUE: {e}')
else:
    print('OK All section references valid and in order arrays')
"

# 3. No invalid form types
echo ""
echo "--- Form Types ---"
grep -rn "form 'get'" sections/ snippets/ layout/ 2>/dev/null && echo "INVALID FORM TYPE 'get'" || echo "OK No invalid form types"

# 4. No deprecated includes
echo ""
echo "--- Deprecated Includes ---"
grep -rn "{% include" sections/ snippets/ layout/ 2>/dev/null && echo "WARNING: DEPRECATED INCLUDES" || echo "OK No deprecated includes"

# 5. Schema validation
echo ""
echo "--- Schema Blocks ---"
for f in sections/*.liquid; do
  python3 -c "
import re, json
with open('$f') as fh:
    content = fh.read()
m = re.search(r'{%[-\s]*schema\s*[-]?%}(.*?){%[-\s]*endschema\s*[-]?%}', content, re.DOTALL)
if m:
    json.loads(m.group(1))
    print(f'OK $f')
else:
    print(f'WARNING: $f — no schema block')
" 2>&1
done

echo ""
echo "=== VALIDATION COMPLETE ==="
