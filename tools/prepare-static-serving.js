const yaml = require("js-yaml");
const fs = require("fs");

let doc;
try {
  doc = yaml.safeLoad(
    fs.readFileSync(
      __dirname + "/../client/assets/onboarding/iso_countries.en.yaml",
      "utf8"
    )
  );
  console.log(doc);
} catch (e) {
  console.log(e);
  throw e;
}

const countries = doc.countries.map((x) => x.alpha_2_code);
console.log(countries);

const srcPath = __dirname + "/../client/assets/content_bundles";
const files = fs.readdirSync(srcPath);

const destDir = __dirname + "/staticContentBuild";
fs.mkdirSync(destDir);

for (const file of files) {
  const regex = /^(?<base>.+)\.(?<lang>[^._]+)(?:_(?<country>[^.]+))?\.yaml$/;
  const m = file.match(regex).groups;
  console.log(m);
  const expanded = m.country
    ? [`${m.base}.${m.lang}_${m.country}.yaml`]
    : countries
        .map((c) => `${m.base}.${m.lang}_${c}.yaml`)
        .filter((f) => !fs.existsSync(srcPath + "/" + f));
  console.log(expanded);
  for (const dest of expanded) {
    const destPath = destDir + "/" + dest;
    fs.copyFileSync(srcPath + "/" + file, destPath);
  }
}

fs.copyFileSync(__dirname + "/../LICENSE", destDir + "/LICENSE");
fs.copyFileSync(__dirname + "/../docs/credits.yaml", destDir + "/credits.yaml");
