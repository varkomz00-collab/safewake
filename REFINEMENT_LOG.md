# SafeWake Refinement Log

## Run 1 — 2026-03-30

### Methodology
Read all Lovable Wake component source files (.tsx), extracted exact Tailwind-to-CSS values, compared section-by-section against current Shopify theme CSS, identified 30+ specific gaps.

### Bugs Fixed
- None found (validation clean on entry)

### Sections Refined

#### slideshow.liquid (Hero)
- Container radius: added responsive 22px mobile -> 28px sm+ (was fixed 22px)
- Height: changed to `75svh` with vh fallback (was `75vh` only)
- Slide transition: 220ms -> 700ms cubic-bezier(0.4, 0, 0.2, 1) to match Lovable's `duration-700`
- Subheading: 11px -> 10px mobile + 12px sm, tracking 0.12em -> 0.15em, added font-weight: 500, opacity 0.78 -> 0.7
- Title: font-weight 700 -> 600, added line-height: 1.25
- CTA glass: simplified to `bg-white/20`, blur 12px -> 24px (blur-xl), border 0.22 -> 0.3 opacity
- Dots: MAJOR — added width expansion (8px inactive -> 32px active pill), gap 8px -> 4px, touch targets 19px -> 44px
- Content overlay: added explicit padding (20px/32px inline, 32px/40px bottom)

#### header.liquid
- Touch targets: radius 0.5rem (8px) -> 9999px (rounded-full), explicit 44x44px sizing
- Nav links: opacity 0.7 -> 0.6, transition 250ms -> 160ms, underline from bottom:0 -> bottom:-6px, transform-origin center -> left, added opacity transition
- Mobile height: added min-height 56px with 12px inline padding
- Desktop: added gap: 16px
- Mobile menu headers: added 11px uppercase with 0.05em tracking

#### main-product.liquid
- Gallery: border-radius 18px -> 16px (rounded-2xl)
- Thumbnails: added explicit 64px mobile / 80px sm sizing
- Active thumbnail: box-shadow -> outline: 2px solid + outline-offset: 2px
- Variant pills: border 1px (hairline) -> 2px solid
- ATC button: min-height 44px -> 48px (h-12)
- Sticky buy box: position sticky -> fixed, added rounded-t-2xl (16px 16px 0 0), safe-area padding

#### main-collection.liquid
- Grid gap: 12px -> 16px
- Added explicit grid-template-columns: repeat(2, 1fr) mobile, repeat(4, 1fr) md
- Filter pills: added min-height 40px, increased padding
- Sort sheet mobile: border-radius to 16px 16px 0 0

#### footer.liquid
- Section padding: added 48px mobile / 64px sm
- Border-top: opacity 0.06 -> 0.12
- Social icons: added padding 10px (p-2.5)

#### collection-list.liquid
- Card radius: 8px (var(--sw-radius-sm)) -> 12px (rounded-xl)
- Added image zoom on hover: scale(1.05) 500ms
- Title tracking: 0.06em -> 0.1em (tracking-widest)

#### featured-collection.liquid
- Section container: added border-radius 24px + overflow hidden (rounded-3xl)
- Nav arrows: changed to bg-background/90 with shadow-lg and backdrop-blur-sm
- Heading: added responsive sizing 24px/30px/36px

#### background-video.liquid
- Title: added responsive sizing 18px mobile / 30px md
- Title tracking: added -0.025em (tracking-tight)
- Eyebrow tracking: 0.16em -> 0.1em (tracking-widest)

#### shop-the-look.liquid
- Title: added responsive sizing 18px mobile / 30px md
- Title tracking: added -0.025em (tracking-tight)
- Eyebrow tracking: 0.16em -> 0.1em (tracking-widest)

### Skills Applied
- Engineering review: CSS specificity audit — all changes scoped to section IDs or specific selectors
- Design system: Token coverage verified against Lovable index.css custom properties

### Remaining Issues (MUST LIST AT LEAST 5)
1. **Testimonials section** — not compared against Lovable yet; needs card radius, star rating, and quote typography audit
2. **Cart drawer** — Lovable has rounded-t-2xl container, checkout button needs verification against WakeStickyAddToCart.tsx patterns
3. **CSS budget exceeded** — safewake-*.css total is 8.5KB (budget was 5KB). Consider minifying or moving section-specific styles entirely into {% style %} blocks
4. **Rich-text section** — not re-audited against WakeUnifiedStrip.tsx; Lovable uses sticky top-[60px] z-20 with backdrop-blur-lg which we don't have
5. **Scrolling banner** — WakeExpressBanner.tsx uses bg-success-fill/10 with border-y border-success-fill/20; our version doesn't match this color scheme
6. **Product page trust strip** — WakeTrustStrip.tsx has specific gap-x-3 gap-y-1 py-2 layout not verified
7. **Mobile menu drawer** — Lovable uses rounded drawer with full separate sheet; ours is a basic slide panel
8. **Collection page filters** — WakeFilterStrip.tsx has express delivery toggle with animate-shake; not implemented
9. **transition: all** — Some sections still use `transition: all` which can cause layout jank; should specify individual properties
10. **Responsive product card widths** — Lovable uses w-[48%]/w-[32%]/w-[24%]/w-[20%] but Shopify grid system handles this differently

### Next Run Should Focus On
- Testimonials + cart drawer comparison against Lovable
- CSS budget optimization (minify or restructure)
- Rich-text / WakeUnifiedStrip sticky navigation strip
- Replace remaining `transition: all` with specific properties
- Mobile CRO: verify ATC button visibility above fold on iPhone SE (375px)
