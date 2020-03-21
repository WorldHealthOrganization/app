// TODO: Product to spec what facets of a user control the content they see.
export default interface UserContext {
  // lowercase ISO 3166-2 region code or the special designator 'ww' for worldwide
  country: string;
  // BCP 47 language tag (ex. en, fr-CA, etc.).  Note the country here (if any) is
  // a linguistic dialect, separate from the country above.
  // TODO: What about back off from language with dialect, to without dialect (fr-CA -> fr)?
  language: string;
}

export const CONTEXT_DEFAULTS: UserContext = {
  country: 'ww',
  language: 'en',
};

export function getUserContext(): UserContext {
  // TODO: Get this from configuration, user overrides, etc.
  return { ...CONTEXT_DEFAULTS };
}
