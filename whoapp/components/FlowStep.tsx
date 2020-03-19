import React from 'react';
import {StyleSheet, Text, View, StyleProp, ViewStyle, Button } from 'react-native';

const styles = StyleSheet.create({
  content: {
    color: '#222',
    fontSize: 20,
  },
  title: {
    color: '#000',
    fontSize: 45,
    fontWeight: 'bold'
  }
});


export interface MenuItem {
  stepId: string;
  label: string;
}

export interface Step {
  stepId: string;
  title?: string;
  content?: string[];
  menuItems?: MenuItem[];
  imgAbove?: string;
  imgBelow?: string;
}

export interface Props extends Step {
  style?: StyleProp<ViewStyle>;
}

const FlowStep : React.FC<Props> = (props) => {
  return (
    <View style={props.style}>
      {props.title && <Text style={styles.title}>{props.title}</Text>}
      {props.content && props.content.map((msg,i) => (
        <Text style={styles.content} key={i}>{msg}</Text>
      ))}
      {props.menuItems && props.menuItems.map((item,i) => (
        <Button key={i} title={item.label} onPress={() => 0}/>
      ))}
    </View>
  );
}

export default FlowStep;
