import React from 'react'
import { StyleSheet, View, Button } from 'react-native'

import FlowStep from './FlowStep';

import Swiper from 'react-native-swiper';

const styles = StyleSheet.create({
  carousel: {},
  slideWrapper: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 40,
  },
  slideContent: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 40,
  },
  text: {
    color: '#222',
    fontSize: 20,
  },
  heading: {
    color: '#000',
    fontSize: 45,
    fontWeight: 'bold'
  }
})

export default function HomeScreen({ navigation }) {
  // TODO: Load from the web, fallback to file.
  // TODO: Choose URI based on locale.
  // TODO: Convert to YAML.
  const steps = require('../data/flow-en.json').flow;

  return (
    <Swiper style={styles.carousel} showsButtons={true}>
      {steps.map((step, idx) =>
        (
          <View style={styles.slideWrapper} key={step.stepId}>
            <FlowStep {...step} style={styles.slideContent} />
            {idx === 0 && <Button onPress={() => navigation.navigate('Credits')} title="Credits &amp; License" />}
          </View>
        )
      )}
    </Swiper>
  );
}
