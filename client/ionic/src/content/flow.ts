import {
  FLOWS_ENDPOINT,
  FLOWS_PATH,
  IMG_ENDPOINT,
  IMG_PATH,
} from './endpoints';
import UserContext, { CONTEXT_DEFAULTS } from './userContext';
import * as yaml from 'js-yaml';

export interface BaseScreen {
  type: string;
  id: string;
}

export interface TextImageScreen extends BaseScreen {
  type: 'TextImage';
  topImageUri?: string;
  headingText: string;
  bodyTexts?: string[];
  bottomImageUri?: string;
}

export interface TextEmojiScreen extends BaseScreen {
  type: 'TextEmoji';
  bodyTexts?: string[];
  bottomEmoji?: string;
}

// TODO: This is an example, and is not yet implemented.
export interface HeroImageScreen extends BaseScreen {
  type: 'HeroImage';
  imageUri: string;
}

export type Screen = TextImageScreen | TextEmojiScreen | HeroImageScreen;

export interface BaseFlow {
  type: string;
  screens: Screen[];
}

export interface CarouselFlow extends BaseFlow {
  type: 'LinearCarousel';
}

export type Flow = CarouselFlow;

export interface LoadedFlow {
  readonly content: Flow;
  readonly isLocal: boolean;
  readonly imgPrefix: string;
}

export class FlowLoader {
  // TODO: Disable pre-v0.1-ship if we are not confident in server support.
  // TODO: A way to disable this easily in development.
  static readonly ENABLE_SERVER_LOAD = false;

  static readonly SUFFIX_DELIM = '.';

  static contextSuffixes(ctx: UserContext): string[] {
    // if you are in Canada using French, you would use the following content in
    // priority order:
    // ca.fr
    // ca.en
    // ww.fr
    // ww.en
    const suffixes = [
      [ctx.country, ctx.language],
      [ctx.country, CONTEXT_DEFAULTS.language],
      [CONTEXT_DEFAULTS.country, ctx.language],
      [CONTEXT_DEFAULTS.country, CONTEXT_DEFAULTS.language],
    ];
    return suffixes
      .map(elems => elems.join(this.SUFFIX_DELIM))
      .filter((val, idx, arr) => idx === arr.indexOf(val));
  }

  static async loadFlow(id: string, ctx: UserContext): Promise<LoadedFlow> {
    const suffixes = this.contextSuffixes(ctx);
    // TODO: make this flow loader aware of device's network / data
    // status to not attempt to load from server if not connected or if on low data mode
    if (FlowLoader.ENABLE_SERVER_LOAD) {
      // TODO: This is a lot of potential 404s. Consider loading a single
      // manifest file (directory listing) that indicates which flows and
      // suffixes exist.
      for (const suffix of suffixes) {
        try {
          const url = `${FLOWS_ENDPOINT}/${id}.${suffix}.yaml`;
          const respText = await fetch(url).then(e => e.text());
          return {
            content: yaml.safeLoad(respText) as Flow,
            isLocal: false,
            imgPrefix: IMG_ENDPOINT,
          };
        } catch (e) {
          // This is fine - we'll use the next less specific (or baked-in) flow instead.
        }
      }
    }
    for (const suffix of suffixes) {
      try {
        const url = `${process.env.PUBLIC_URL}/${FLOWS_PATH}/${id}.${suffix}.yaml`;
        const respText = await fetch(url).then(e => e.text());
        return {
          content: yaml.safeLoad(respText) as Flow,
          isLocal: true,
          imgPrefix: IMG_PATH,
        };
      } catch (e) {
        // This is fine - we'll use the next less specific flow instead.
      }
    }
    // The requested flow does not exist in the server or locally,
    // TODO: the UI must handle this error (just go back to main menu?).
    throw new Error(
      `Flow ${id} cannot be fetched from the server or app package.`
    );
  }
}
