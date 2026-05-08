import type { Config } from "tailwindcss";
export default {
  content: ["./src/**/*.{js,ts,jsx,tsx,mdx}"],
  theme: {
    extend: {
      colors: {
        navy: {
          50:"#eef2ff",100:"#dbe4ff",200:"#bac8ff",300:"#91a7ff",400:"#748ffc",
          500:"#5c7cfa",600:"#4c6ef5",700:"#4263eb",800:"#3b5bdb",900:"#1e3a8a",950:"#0a1628"
        },
        gold: {
          50:"#fdf8e8",100:"#faefc5",200:"#f5e08e",300:"#f0cb4d",
          400:"#D4AF37",500:"#c49b2a",600:"#a87e21",700:"#86601c",800:"#704f1d",900:"#5f421d",950:"#37240e"
        },
        cream: {50:"#FFFDF7",100:"#FFF8F0",200:"#FEF0D5",300:"#FDE4B0"}
      },
      fontFamily: {
        heading:["Playfair Display","serif"],
        body:["Inter","sans-serif"]
      }
    }
  },
  plugins: []
} satisfies Config;
