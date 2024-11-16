p

# Init App

```powershell
npx nuxi init <app>
```

# Eslint

```powershell
yarn add -D eslint
yarn add -D @nuxtjs/eslint-module


```

1. Add `@nuxtjs/eslint-module` to the `modules` section of `nuxt.config.ts`

```ts
export default defineNuxtConfig({  modules: [    // Simple usage    '@nuxtjs/eslint-module',    // With options    ['@nuxtjs/eslint-module', { /* module options */ }]  ]})
```

# Pinia

```powershell
npm i @pinia/nuxt
```

config

```ts
// Nuxt 3
export default defineNuxtConfig({ modules: ["@pinia/nuxt"] });
```

# Auto-animate

```powershell
yarn add @formkit/auto-animate
```

# Nuxt-vutify

```powershell
yarn add --dev "@invictus.codes/nuxt-vuetify"
```

nuxt-vutify

```powershell
yarn add @nuxt/ui


```

pnpm dev
