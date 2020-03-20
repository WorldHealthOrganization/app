import React, { Component } from 'react'
import { StyleSheet, Text, View } from 'react-native'

import Swiper from 'react-native-swiper';

const styles = StyleSheet.create({
  wrapper: {},
  slide1: {
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

export default class HomeScreen extends Component {
  render() {
    return (
      <Swiper style={styles.wrapper} showsButtons={true}>
        <View style={styles.slide1}>
          <Text style={styles.heading}>COVID App</Text>
          <Text style={styles.text}>[This is a prototype. Use at your own risk.]</Text>
        </View>
        <View style={styles.slideContent}>
          <Text style={styles.heading}>How It Spreads</Text>
          <Text style={styles.text}>COVID-19, also referred to as "Coronavirus" mainly spreads between people who are in close contact with one another (within about 6 feet or two meters) through respiratory droplets produced when an infected person coughs or sneezes.</Text>
        </View>
        <View style={styles.slideContent}>
          <Text style={styles.heading}>Avoid Close Contact</Text>
          <Text style={styles.text}>Avoid close contact with people who are sick.</Text>
          <Text style={styles.text}>Put distance between yourself and other people if COVID-19 is spreading in your community.  This is especially important for people who are at higher risk of getting very sick, including the elderly.</Text>
        </View>
      </Swiper>
    )
  }
}
