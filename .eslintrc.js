const { resolve } = require("node:path")

const project = resolve(__dirname, "tsconfig.json")

module.exports = {
	root: true,
	extends: [
		require.resolve("@vercel/style-guide/eslint/browser"),
		require.resolve("@vercel/style-guide/eslint/react"),
		require.resolve("@vercel/style-guide/eslint/next"),
		require.resolve("@vercel/style-guide/eslint/node"),
		require.resolve("@vercel/style-guide/eslint/typescript")
	],
	parserOptions: { project },
	settings: { "import/resolver": { typescript: { project } } },
	rules: {
		"@typescript-eslint/explicit-function-return-type": 1,
		"@typescript-eslint/no-misused-promises": 2,
		"import/no-extraneous-dependencies": 2,
		"import/order": 2,
		"no-console": 1,
		"react/jsx-sort-props": 2,
	}
  // Note: 0 = off, 1 = warn, 2 = error
}
