#!/usr/bin/python3

# Generates iso_countries.*.yaml files from WHO official list of countries:
# "Detailed_Boundary_ADM0 (24).csv" (stored in Google Drive)

import csv
import sys
import unicodedata

iso_2_code = 'ISO_2_CODE'
fields = {
    'en': 'ADM0_VIZ_NAME',
    'ar': 'ARABIC',
    'es': 'SPANISH',
    'fr': 'FRENCH',
    'ru': 'RUSSIAN',
    'zh_CN': 'CHINESE'} # Simplified Chinese

# Rewrite certain country names
substitutions = {
    ' ': '',
    'The United Kingdom': 'United Kingdom'}

output = 'client/assets/onboarding/iso_countries.{}.yaml'
output_hdr = 'countries:\n'
output_str = (
    '  - name: {}\n'
    '    alpha_2_code: {}\n')

def accent_case_normalization(name):
    return unicodedata.normalize("NFKD", name.casefold()).encode('ASCII', 'ignore')

def main(argv):
    print('Reading: ' + sys.argv[1])
    with open(sys.argv[1], newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        countries = []
        old_alpha2 = ''
        for row in reader:
            alpha2 = row[iso_2_code]
            assert(len(alpha2) == 2)
            country = [alpha2]
            for field in fields:
                name = row[fields[field]]
                if name in substitutions:
                    name = substitutions[name]
                country.append(name)

            if alpha2 == old_alpha2:
                print('Duplicated alpha 2 code: ' + str(country))
                continue
            old_alpha2 = alpha2
            countries.append(country)

    fields_list = list(fields.keys())
    for num, lang in enumerate(fields_list):
        filename = output.format(lang)
        with open(filename, 'w') as f:
            countries = sorted(countries,
                # https://stackoverflow.com/a/29247821/1509221
                key=lambda country: accent_case_normalization(country[num+1]))
            f.write(output_hdr)
            for country in countries:
                name = country[num+1]
                if name:
                    f.write(output_str.format(name, country[0]))

if __name__ == "__main__":
    sys.exit(main(sys.argv))
