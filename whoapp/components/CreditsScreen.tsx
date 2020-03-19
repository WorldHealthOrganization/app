import React from 'react'
import { StyleSheet, Text, View, ScrollView, Linking } from 'react-native'

const styles = StyleSheet.create({
  wrapper: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 20,
  },
  text: {
    color: '#222',
    fontSize: 14,
    marginBottom: 8,
  },
  link: {
    color: 'blue',
    fontSize: 14,
    marginBottom: 8,
  },
  licenseText: {
    color: '#222',
    fontSize: 12,
  },
  heading: {
    color: '#000',
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
  }
})

export default function CreditsScreen() {
  const credits = require('../data/credits.json');
  const teamMembers = credits.team.join(', ');
  const supporters = credits.supporters.join(', ');
  return (
    <View style={styles.wrapper}>
      <ScrollView>
        <Text style={styles.heading}>WHO App</Text>
        <Text style={styles.link}
          onPress={() => Linking.openURL('https://github.com/WorldHealthOrganization/app')}>
          https://github.com/WorldHealthOrganization/app
        </Text>
        <Text style={styles.text}>Built by the WHO COVID App Collective:{"\n"}{teamMembers}</Text>
        <Text style={styles.text}>With the generous support of:{"\n"}{supporters}</Text>
        <Text style={styles.licenseText}>
          Copyright (c) 2020 World Health Organization{"\n"}
          {"\n"}
          Permission is hereby granted, free of charge, to any person obtaining a copy
          of this software and associated documentation files (the "Software"), to deal
          in the Software without restriction, including without limitation the rights
          to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
          copies of the Software, and to permit persons to whom the Software is
          furnished to do so, subject to the following conditions:{"\n"}
          {"\n"}
          The above copyright notice and this permission notice shall be included in all
          copies or substantial portions of the Software.{"\n"}
          {"\n"}
          THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
          IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
          FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
          AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
          LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
          OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
          SOFTWARE.
          </Text>
      </ScrollView>
    </View>
  );
}
