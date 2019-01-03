rm -rf "aarkay-plugin-{{ cookiecutter.name|lower }}"
cp -R "aarkay-plugin-PLUGINLOWERNAME" "aarkay-plugin-PLUGINLOWERNAME.bak"

# Do replacements
function replace {
  LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec sed -i '' "s/$1/$2/g" {} +
}
replace "PLUGINLOWERNAME" "{{ cookiecutter.name|lower}}"
replace "PLUGINNAME" "{{ cookiecutter.name }}"
replace "PLUGINSUMMARY" "{{ cookiecutter.summary }}"
replace "PLUGINGITHUB" "{{ cookiecutter.github }}"

# Do Renames
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "AarKayPLUGINNAME" "AarKay{{ cookiecutter.name }}" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "AarKayPLUGINNAMECLI" "AarKay{{ cookiecutter.name }}CLI" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "PLUGINNAME.Template.yml" "{{ cookiecutter.name }}.Template.yml" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "PLUGINNAME.txt.stencil" "{{ cookiecutter.name }}.txt.stencil" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "PLUGINNAME.yml" "{{ cookiecutter.name }}.yml" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "PLUGINNAME.swift" "{{ cookiecutter.name }}.swift" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "PLUGINLOWERNAME" "{{ cookiecutter.name|lower }}" {} +
LC_ALL=C find ./aarkay-plugin-PLUGINLOWERNAME -type f -exec rename -p -S "aarkay-plugin-PLUGINLOWERNAME" "aarkay-plugin-{{ cookiecutter.name|lower }}" {} +

rm -rf aarkay-plugin-PLUGINLOWERNAME
mv aarkay-plugin-PLUGINLOWERNAME.bak aarkay-plugin-PLUGINLOWERNAME

rm -rf "aarkay-plugin-{{ cookiecutter.name|lower }}/.build"
rm -rf "aarkay-plugin-{{ cookiecutter.name|lower }}"/*.xcodeproj
rm "aarkay-plugin-{{ cookiecutter.name|lower }}/Package.resolved"
mv "aarkay-plugin-{{ cookiecutter.name|lower }}/.gitignore" "aarkay-plugin-{{ cookiecutter.name|lower }}/_gitignore"
