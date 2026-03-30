# SafeWake Go-To-Market Log

## GTM Run 1 — 2026-03-30

### Step 1: Customizability Audit
**Status: PASS**
- Header logo: `image_picker` setting exists (id=logo), Liquid reads `section.settings.logo` — correctly wired
- Transparent logo: `image_picker` exists (id=transparent_logo) — correctly wired
- Navigation menu: `link_list` setting (id=menu_linklist), Liquid reads via `linklists[section.settings.menu_linklist]` — correctly wired
- All homepage sections use block-level `image_picker` for images (slideshow, testimonials, collection-list, image-with-text, gallery)
- No hardcoded customer-facing text found — all text comes from schema settings or translation keys
- Hardcoded URLs: Only PageFly remnants and Tamara payment widget (external services, not theme content)

### Step 2: SEO Hardening
**Status: IMPROVED**
- Meta tags: title, description, canonical — all present in `doc-head-core.liquid`
- Open Graph: og:title, og:url, og:type, og:description, og:image, og:price — all present in `doc-head-social.liquid`
- Twitter Cards: summary_large_image, title, description — present
- Structured data: Organization (with sameAs for social), WebSite (with SearchAction), Product, Article, BreadcrumbList — all present
- Heading hierarchy: H1 controlled by schema `use_h1` setting — correct (one per page)
- **ADDED: Preconnect hints** in `layout/theme.liquid`:
  - `<link rel="preconnect" href="https://cdn.shopify.com" crossorigin>`
  - `<link rel="preconnect" href="https://fonts.shopifycdn.com" crossorigin>`
  - `<link rel="dns-prefetch" href="https://productreviews.shopifycdn.com">`

### Step 3: Product Page CRO
**Status: PASS**
- ATC button: present (6 references in main-product.liquid)
- Price display: present with compare-at price support
- Variant selector: full implementation (22 references)
- Breadcrumbs: present with schema toggle
- Related products: dedicated section in product.json template
- Trust signals: 13 references (custom-liquid blocks for shipping, guarantee, secure checkout)
- Reviews: 37 references (rating, star display integration)
- Template block order: title → vendor → divider → price → inventory-level → variant-picker → buy-buttons → custom-liquid (trust) → description

### Step 4: Collection Page CRO
**Status: PASS**
- Grid: 5-column setting with responsive 2→3→4 CSS progression
- Filters: enabled with sticky behavior, two-column layout, show disabled filters
- Sort: all options enabled (featured, best-selling, alphabetical, price, date)
- Empty state: 9 references handling empty collection
- Mobile grid: 2-column default
- Collection strip: active state with brand glow tokens

### Step 5: Mobile-First Pass
**Status: IMPROVED**
- Viewport meta: `width=device-width,initial-scale=1` — correct
- Touch targets: All interactive elements use 44px minimum via `min-width`/`min-height` pattern (visual size can be smaller, touch target is always 44px)
- **FIXED: iOS input zoom** — Newsletter email input was `font-size: 14px` → changed to `16px` (iOS zooms on inputs < 16px)
- Sticky elements: Header sticky with proper z-index, buy box sticky on mobile with safe-area padding
- Overflow: No horizontal scroll issues detected in our CSS additions

### Step 6: Missing Templates
**Status: PASS — All 19 Required Templates Present**
- 404.json, article.json, blog.json, cart.json, collection.json
- customers/account.liquid, customers/activate_account.liquid, customers/addresses.liquid
- customers/login.liquid, customers/order.liquid, customers/register.liquid, customers/reset_password.liquid
- gift_card.liquid, index.json, list-collections.json
- page.json (+ page.contact.json, page.faq.json), password.json, product.json, search.json

### Step 7: Skill Rotation
**GTM Run 1 rotation: CRO + Conversion focus**
- Product page buy flow: All elements present and properly ordered. Inventory level before variant picker creates urgency before selection — good CRO pattern.
- Newsletter: Pill-shaped input with glow focus ring draws attention. 16px font prevents iOS zoom frustration that kills mobile conversion.
- Preconnect hints: Faster CDN connection = faster LCP = lower bounce rate. Direct conversion impact via performance.

### Issues Found & Fixed This Run
1. **Missing preconnect hints** — Added 3 resource hints for Shopify CDN, fonts, and reviews
2. **iOS input zoom bug** — Newsletter email input at 14px caused unwanted zoom on iPhone. Fixed to 16px.

### Remaining GTM Issues
1. **PageFly remnants** — `pagefly-head` render in theme.liquid + pagefly snippet files. If PageFly is no longer used, these add ~2KB of unused CSS/JS.
2. **Tamara widget** — External script loaded on every page via snippet. Should be conditionally loaded only on product/cart pages.
3. **Product reviews integration** — References exist but no dedicated reviews section visible in product.json. May need Shopify Product Reviews app configured.
4. **Newsletter double-opt-in** — No confirmation message customization visible. UAE market may need Arabic language support.
5. **Cart drawer cross-sell** — Has upsell slots but effectiveness depends on Shopify recommendation algorithm being configured.
6. **Search experience** — Uses Symmetry's built-in predictive search. Could benefit from AI-powered search integration.
7. **Collection filter UX** — `show_filter_counts: False` hides how many products match each filter. Enabling this improves user confidence.
8. **Mobile sort** — Bottom sheet exists but radius/backdrop-filter not verified for premium feel.

### Next GTM Run Should Focus On
- PageFly cleanup (if no longer needed)
- Tamara widget conditional loading
- Filter count enablement
- A/B test plan for CTA wording
- AI SEO audit (structured data completeness for AI search)
