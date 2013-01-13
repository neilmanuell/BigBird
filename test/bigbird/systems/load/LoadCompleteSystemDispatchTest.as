package bigbird.systems.load {
import bigbird.api.signals.OnLoaded;
import bigbird.components.io.Loader;
import bigbird.controller.Removals;
import bigbird.controller.StartWordFileDecode;
import bigbird.nodes.LoadingNode;
import bigbird.systems.utils.removal.ActivityMonitor;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;
import mockolate.stub;

import net.richardlord.ash.core.Entity;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;

import supporting.values.requests.URL_WELL_FORMED_DOCUMENT_DOCX;

public class LoadCompleteSystemDispatchTest {
    private var _classUnderTest:LoadCompleteSystem;
    private var _onLoaded:OnLoaded;
    private var _startDecode:StartWordFileDecode;
    private var _activityMonitor:ActivityMonitor;
    private var _removals:Removals;

    [Before(order=1, async, timeout=5000)]
    public function prepareMockolates():void {
        Async.proceedOnEvent(this,
                prepare(OnLoaded, StartWordFileDecode, Loader, ActivityMonitor, Removals),
                Event.COMPLETE);
    }

    [Before(order=2)]
    public function before():void {
        _onLoaded = nice(OnLoaded);
        _startDecode = nice(StartWordFileDecode);
        _classUnderTest = new LoadCompleteSystem(_onLoaded, _startDecode);
        _activityMonitor = nice(ActivityMonitor);
        _removals = nice(Removals);
        _classUnderTest.activityMonitor = _activityMonitor;
        _classUnderTest.removals = _removals;
    }

    [Test]
    public function dispatches_on_complete():void {
        const node:LoadingNode = createLoadingNode(true, true);
        _classUnderTest.updateNode(node, 0);
        assertThat(_onLoaded, received().method("dispatchWordData").arg(node.loader).once());
    }

    [Test]
    public function before_complete_activity_confirmed():void {
        const node:LoadingNode = createLoadingNode(false, true);
        _classUnderTest.updateNode(node, 0);
        assertThat(_activityMonitor, received().method("confirmActivity").once());
    }

    [Test]
    public function on_complete_and_successful_decode_WordFile():void {
        const node:LoadingNode = createLoadingNode(true, true);
        _classUnderTest.updateNode(node, 0);
        assertThat(_startDecode, received().method("decode").arg(node).once());
    }

    [Test]
    public function on_complete_and_unsuccessful_remove_Entity():void {
        const node:LoadingNode = createLoadingNode(true, false);
        _classUnderTest.updateNode(node, 0);
        assertThat(_removals, received().method("removeEntity").arg(node.entity).once());
    }

    private function createLoadingNode(isComplete:Boolean, success:Boolean):LoadingNode {
        const node:LoadingNode = new LoadingNode();
        const loader:Loader = nice(Loader, "Loader", [URL_WELL_FORMED_DOCUMENT_DOCX]);
        stub(loader).getter("isLoadComplete").returns(isComplete);
        stub(loader).getter("success").returns(success);

        node.loader = loader;
        node.entity = new Entity();
        return node;
    }


}
}
