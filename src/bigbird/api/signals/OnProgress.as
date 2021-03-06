package bigbird.api.signals {
import bigbird.api.vos.ProgressVO;
import bigbird.components.BigBirdProgress;

import net.richardlord.signals.Signal1;

public class OnProgress extends Signal1 {
    public function OnProgress() {
        super(ProgressVO);
    }

    public function dispatchProgress(progress:BigBirdProgress):void {
        dispatch(new ProgressVO(progress));
    }
}
}
