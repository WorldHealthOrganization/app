import { useEffect, useState } from 'react';
import { FlowLoader, LoadedFlow } from '../content/flow';
import { getUserContext } from '../content/userContext';

export default function useDynamicFlow(id: string) {
  const [flow, setFlow] = useState({} as LoadedFlow);

  useEffect(() => {
    async function fetchFlow() {
      const f = await FlowLoader.loadFlow(id, getUserContext());
      setFlow(f);
    }
    fetchFlow();
  }, [id]);

  return flow;
}
