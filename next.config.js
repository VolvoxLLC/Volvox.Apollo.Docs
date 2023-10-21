const withNextra = require("nextra")({
	theme: "nextra-theme-docs",
	themeConfig: "./theme.config.tsx"
})

module.exports = withNextra({
	// basePath: "/docs",
	content: [
		"./pages/**/*.{js,jsx,ts,tsx,md,mdx}",
		"./components/**/*.{js,jsx,ts,tsx,md,mdx}"
	],
	eslint: {
		// Warning: This allows production builds to successfully complete even if your project has ESLint errors.
		ignoreDuringBuilds: true
	}
})
