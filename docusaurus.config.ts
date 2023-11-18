import { themes as prismThemes } from 'prism-react-renderer';
import type { Config } from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'Volvox.Apollo Docs',
  tagline: 'Documentation for Volvox.Apollo',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://apollo.volvox.tech',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/apollo-docs/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'Volvox LLC', // Usually your GitHub org/user name.
  projectName: 'Volvox.Apollo', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'throw',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/VolvoxLLC/Volvox.Apollo.Docs/tree/master',
        },
        blog: {
          showReadingTime: true,
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/VolvoxLLC/Volvox.Apollo.Docs/tree/master',
        },
        theme: {
          customCss: ['./src/css/custom.scss']
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    algolia: {
      // The application ID provided by Algolia
      appId: '6QKKWL16HE',

      // Public API key: it is safe to commit it
      apiKey: 'e1aa42d4fc426edfca8b31d1b73f6289',

      indexName: 'apollo-volvox',

      // Optional: see doc section below
      contextualSearch: false,

      // Optional: Specify domains where the navigation should occur through window.location instead on history.push. Useful when our Algolia config crawls multiple documentation sites and we want to navigate with window.location.href to them.
      externalUrlRegex: 'apollo.volvox\\.tech',

      // Optional: Replace parts of the item URLs from Algolia. Useful when using the same search index for multiple deployments using a different baseUrl. You can use regexp or string in the `from` param. For example: localhost:3000 vs myCompany.com/docs
      replaceSearchResultPathname: {
        from: '/docs/', // or as RegExp: /\/docs\//
        to: '/',
      },

      // Optional: Algolia search parameters
      searchParameters: {},

      // Optional: path for search page that enabled by default (`false` to disable it)
      searchPagePath: 'search',
    },
    image: 'img/Apollo-Banner.jpg',
    navbar: {
      title: 'Volvox.Apollo Docs',
      logo: {
        alt: 'Volvox.Apollo Logo',
        src: 'svg/Apollo-Logo.svg',
        className: 'logo',
      },
      items: [
        {
          position: 'left',
          label: 'Apollo',
          to: 'https://apollo.volvox.tech',
        },
        {
          to: '/apollo-docs/',
          position: 'left',
          label: 'Home'
        },
        {
          type: 'doc',
          position: 'left',
          docId: 'intro',
          label: 'Docs'
        },
        {
          to: '/blog/',
          label: 'Blog',
          position: 'left'
        },
        {
          to: 'https://github.com/VolvoxLLC',
          position: 'right',
          className: 'github-link',
        },
        {
          to: 'https://discord.gg/Y6BgvsWuNU',
          position: 'right',
          className: 'discord-link',
        },
      ],
    },
    prism: {
      theme: prismThemes.oneLight,
      darkTheme: prismThemes.oneDark,
      additionalLanguages: ['json']
    },
    colorMode: {
      defaultMode: 'dark',
      respectPrefersColorScheme: true,
    },
  } satisfies Preset.ThemeConfig,

  // Custom Plugins
  plugins: [
    'docusaurus-plugin-sass'
  ]
};

export default config;
