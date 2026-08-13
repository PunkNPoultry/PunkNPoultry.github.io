import "$styles/index.css"
import "$styles/syntax-highlighting.css"
import Willamette from "willamette"

Willamette.init()

// Import all JavaScript & CSS files from src/_components
import components from "$components/**/*.{js,jsx,js.rb,css}"
import '@awesome.me/webawesome/dist/components/relative-time/relative-time.js';
console.info("Bridgetown is loaded!")
